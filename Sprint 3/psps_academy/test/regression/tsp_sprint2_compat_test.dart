import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:psps/core/content/catalog.dart';
import 'package:psps/core/learning/gamification.dart';
import 'package:psps/core/learning/learning_controller.dart';
import 'package:psps/core/models/course.dart';
import 'package:psps/core/persistence/progress_store.dart';
import 'package:psps/features/notes/notes_controller.dart';
import 'package:psps/features/notes/notes_store.dart';
import 'package:psps/features/reminders/reminder_controller.dart';
import 'package:psps/features/reminders/reminder_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'tsp_sprint2_compat_fixture.dart';

// Solo se sustituye la frontera de preferencias y notificaciones nativas.
// Stores, controladores, catálogo ampliado y serializadores son los reales.
class _Preferences extends Fake implements SharedPreferencesAsync {
  _Preferences(String progress, [String reminder = tspEnabledReminder])
    : values = {
        tspProgressKey: progress,
        tspNotesKey: tspNotes,
        tspReminderKey: reminder,
        'unrelated.setting': 'conservar',
      };

  final Map<String, String> values;
  final List<String> writes = [];

  @override
  Future<String?> getString(String key) async => values[key];

  @override
  Future<void> setString(String key, String value) async {
    writes.add(key);
    values[key] = value;
  }
}

class _Notifications extends Fake implements NotificationPort {
  final Map<int, (int, int)> scheduled = {};
  final Set<int> cancelled = {};
  int requests = 0;

  @override
  Future<void> initialize({required VoidCallback onOpened}) async {}

  @override
  Future<bool> hasPermission() async => true;

  @override
  Future<bool> requestPermission() async {
    requests++;
    return true;
  }

  @override
  Future<void> scheduleDay({
    required int weekday,
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    scheduled[weekday] = (hour, minute);
  }

  @override
  Future<void> cancelDay(int weekday) async => cancelled.add(weekday);
}

Map<String, dynamic> _json(String raw) =>
    jsonDecode(raw) as Map<String, dynamic>;

Future<LearningController> _open(_Preferences preferences) async {
  final controller = LearningController(
    modules: catalog,
    store: LocalProgressStore(preferences: preferences),
  );
  addTearDown(controller.dispose);
  await controller.load();
  expect(controller.ready, isTrue, reason: controller.loadError);
  return controller;
}

void _expectProgress(LearningController controller, Map<String, dynamic> json) {
  expect({
    for (final q in controller.questions)
      if (controller.answerFor(q) != null) q.id: controller.answerFor(q),
  }, json['answers']);
  expect({
    for (final q in controller.questions)
      if (controller.reviewAnswerFor(q) != null)
        q.id: controller.reviewAnswerFor(q),
  }, json['reviewAnswers']);
  expect({
    for (final p in controller.practices)
      if (controller.orderFor(p).isNotEmpty) p.id: controller.orderFor(p),
  }, json['practices']);
  expect(controller.points, json['points']);
  expect(controller.earnedAchievements, json['achievements']);
  expect(controller.selectedTheme, json['selectedTheme']);
  expect(controller.newAchievements, isEmpty);
  expect(controller.newThemes, isEmpty);
}

void main() {
  test(
    'TSP2-01: original answer indexes, activity positions and reward IDs',
    () {
      // Fuente independiente: los valores literales proceden del catálogo de
      // Sprint 2, no de legacyView ni de preguntas generadas con el catálogo nuevo.
      final json = _json(tspCompleteProgress);
      final answers = json['answers'] as Map;
      final practices = json['practices'] as Map;
      final questions = catalog.expand((m) => m.questions);
      final activities = catalog
          .expand((m) => m.topics)
          .expand((t) => t.practices);
      expect(answers, hasLength(20));
      expect(practices, hasLength(10));
      for (final entry in answers.entries) {
        final q = questions.singleWhere((q) => q.id == entry.key);
        expect(q.correctIndex, entry.value, reason: q.id);
        expect(q.options, hasLength(3), reason: q.id);
      }
      for (final entry in practices.entries) {
        final p = activities.singleWhere((p) => p.id == entry.key);
        expect(p.steps, hasLength(3), reason: p.id);
        expect(entry.value, [0, 1, 2]);
      }
      expect(
        Gamification.achievements.map((a) => a.id).toSet(),
        (json['achievements'] as Map).keys.toSet(),
      );
      expect(Gamification.themes.map((t) => t.id).toSet(), {
        'U-00',
        'U-01',
        'U-02',
        'U-03',
      });
    },
  );

  for (final fixture in {
    'complete': tspCompleteProgress,
    'mixed': tspMixedProgress,
  }.entries) {
    test(
      'TSP2-02 ${fixture.key}: literal v3 loads without writes or loss',
      () async {
        final preferences = _Preferences(fixture.value);
        final before = Map.of(preferences.values);
        final json = _json(fixture.value);
        final controller = await _open(preferences);
        _expectProgress(controller, json);
        expect(controller.answeredCount, (json['answers'] as Map).length);
        expect(controller.progress, (json['answers'] as Map).length / 40);
        expect(
          controller.completedPractices,
          fixture.key == 'complete' ? 10 : 1,
        );
        expect(controller.earnedAchievements['L-02'], tspDate);
        // Completado histórico pasa a En progreso al añadir q3/q4; sus
        // respuestas, premio de subtema y fecha continúan presentes.
        expect(
          controller.lessonStatus(catalog.first.topics.first.lessons.first),
          ProgressStatus.inProgress,
        );
        if (fixture.key == 'complete') {
          expect(controller.unlockedThemes, {'U-00', 'U-01', 'U-02', 'U-03'});
        } else {
          expect(
            controller.pendingReview(controller.questions).map((q) => q.id),
            ['CT-02.s1.q1'],
          );
        }
        _expectProgress(await _open(preferences), json);
        expect(preferences.values, before);
        expect(preferences.writes, isEmpty);
      },
    );

    test(
      'TSP2-03 ${fixture.key}: new answer preserves all historical fields',
      () async {
        final preferences = _Preferences(fixture.value);
        final controller = await _open(preferences);
        final question = controller.questions.singleWhere(
          (q) => q.id == 'CT-01.s1.q3',
        );
        final expected = _json(fixture.value);
        (expected['answers'] as Map)[question.id] = question.correctIndex;
        expect(
          await controller.answer(question, question.correctIndex),
          isTrue,
        );
        expect(_json(preferences.values[tspProgressKey]!), expected);
        expect(preferences.writes, [tspProgressKey]);
        expect(preferences.values[tspNotesKey], tspNotes);
        expect(preferences.values[tspReminderKey], tspEnabledReminder);
        expect(preferences.values['unrelated.setting'], 'conservar');
        final reopened = await _open(preferences);
        _expectProgress(reopened, expected);
        // Una actividad histórica ya premiada nunca vuelve a dar puntos.
        final practice = reopened.practices.singleWhere(
          (p) => p.id == 'CT-01.a1',
        );
        expect(await reopened.saveOrder(practice, [0, 1, 2]), isTrue);
        expect(await reopened.selectTheme(reopened.selectedTheme), isTrue);
        expect(preferences.writes, [tspProgressKey]);
        expect(_json(preferences.values[tspProgressKey]!), expected);
      },
    );
  }

  test(
    'TSP2-04: all ten original notes preserve text, UTC dates and other keys',
    () async {
      final preferences = _Preferences(tspMixedProgress);
      final store = LocalNotesStore(preferences: preferences);
      final notes = NotesController(modules: catalog, store: store);
      addTearDown(notes.dispose);
      await notes.load();
      expect(notes.ready, isTrue, reason: notes.loadError);
      final expected = _json(tspNotes)['notes'] as Map;
      expect(notes.visibleNotes, hasLength(10));
      for (final item in notes.visibleNotes) {
        expect(item.note.lessonId, item.lesson.id);
        expect(item.note.text, expected[item.lesson.id]['text']);
        expect(item.note.modifiedAt.isUtc, isTrue);
        expect(item.note.modifiedAt.toIso8601String(), tspDate);
      }
      expect(preferences.writes, isEmpty);
      // El round trip conserva incluso los bytes escritos por el encoder viejo.
      await store.save(await store.load());
      expect(preferences.values[tspNotesKey], tspNotes);
      final first = catalog.first.topics.first.lessons.first;
      expect(
        await notes.saveNote(first, 'Nota editada después de actualizar'),
        isTrue,
      );
      final reopened = NotesController(modules: catalog, store: store);
      addTearDown(reopened.dispose);
      await reopened.load();
      expect(reopened.ready, isTrue);
      expect(
        reopened.noteFor(first)!.text,
        'Nota editada después de actualizar',
      );
      final saved = _json(preferences.values[tspNotesKey]!)['notes'] as Map;
      expect(saved.length, 10);
      expect(saved[first.id]['modifiedAt'], endsWith('Z'));
      saved.remove(first.id);
      expected.remove(first.id);
      expect(saved, expected);
      expect(preferences.values[tspProgressKey], tspMixedProgress);
      expect(preferences.values[tspReminderKey], tspEnabledReminder);
      expect(preferences.values['unrelated.setting'], 'conservar');
      expect(preferences.writes, [tspNotesKey, tspNotesKey]);
    },
  );

  for (final raw in [tspEnabledReminder, tspDisabledReminder]) {
    test(
      'TSP2-05: original reminder ${_json(raw)['enabled']} reconciles and persists',
      () async {
        final preferences = _Preferences(tspMixedProgress, raw);
        final store = LocalReminderStore(preferences: preferences);
        final port = _Notifications();
        final controller = ReminderController(store: store, port: port);
        addTearDown(controller.dispose);
        await controller.load();
        expect(controller.ready, isTrue, reason: controller.loadError);
        expect(controller.settings.toJson(), _json(raw));
        expect(preferences.writes, isEmpty);
        expect(preferences.values[tspReminderKey], raw);
        expect(port.requests, 0);
        expect(
          port.scheduled,
          controller.settings.enabled
              ? {1: (23, 59), 4: (23, 59), 7: (23, 59)}
              : isEmpty,
        );
        expect(
          port.cancelled,
          controller.settings.enabled ? {2, 3, 5, 6} : {1, 2, 3, 4, 5, 6, 7},
        );
        await store.save(controller.settings);
        expect(preferences.values[tspReminderKey], raw);
        expect((await store.load()).toJson(), _json(raw));
        expect(preferences.writes, [tspReminderKey]);
        expect(preferences.values[tspProgressKey], tspMixedProgress);
        expect(preferences.values[tspNotesKey], tspNotes);
        expect(preferences.values['unrelated.setting'], 'conservar');
      },
    );
  }
}
