import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:psps/core/content/catalog.dart';
import 'package:psps/core/learning/gamification.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Verificación de procedencia para este repositorio de cierre: importa la
// referencia histórica en SOLO LECTURA. Las regresiones normales de test/ no
// necesitan esa carpeta para ejecutarse en una distribución independiente.
// ignore: avoid_relative_lib_imports
import '../../../../Sprint 2/psps_academy/lib/data/catalog.dart' as old_catalog;
// ignore: avoid_relative_lib_imports
import '../../../../Sprint 2/psps_academy/lib/data/notes_store.dart'
    as old_notes;
// ignore: avoid_relative_lib_imports
import '../../../../Sprint 2/psps_academy/lib/data/progress_store.dart'
    as old_progress;
// ignore: avoid_relative_lib_imports
import '../../../../Sprint 2/psps_academy/lib/data/reminder_store.dart'
    as old_reminder;
// ignore: avoid_relative_lib_imports
import '../../../../Sprint 2/psps_academy/lib/domain/learning_controller.dart'
    as old_learning;
// ignore: avoid_relative_lib_imports
import '../../../../Sprint 2/psps_academy/lib/domain/gamification.dart'
    as old_gamification;

import '../../test/regression/tsp_sprint2_compat_fixture.dart';

class _Preferences extends Fake implements SharedPreferencesAsync {
  final Map<String, String> values = {};
  final List<String> writes = [];

  @override
  Future<String?> getString(String key) async => values[key];

  @override
  Future<void> setString(String key, String value) async {
    values[key] = value;
    writes.add(key);
  }
}

void main() {
  test('ORIGIN catalog: all 68 historical IDs and their semantics survive', () {
    final oldIds = <String>{};
    final currentIds = <String>{};
    for (final module in catalog) {
      currentIds.add(module.id);
      for (final topic in module.topics) {
        currentIds.add(topic.id);
        currentIds.addAll(topic.practices.map((p) => p.id));
        for (final lesson in topic.lessons) {
          currentIds.add(lesson.id);
          currentIds.addAll(lesson.questions.map((q) => q.id));
        }
      }
    }
    currentIds.addAll(Gamification.achievements.map((a) => a.id));
    currentIds.addAll(Gamification.themes.map((t) => t.id));
    for (final module in old_catalog.catalog) {
      oldIds.add(module.id);
      final currentModule = catalog.singleWhere((m) => m.id == module.id);
      for (final topic in module.topics) {
        oldIds.addAll([topic.id, topic.practice.id]);
        final currentTopic = currentModule.topics.singleWhere(
          (t) => t.id == topic.id,
        );
        expect(currentTopic.practice.id, topic.practice.id);
        expect(currentTopic.practice.steps, topic.practice.steps);
        for (final lesson in topic.lessons) {
          oldIds.add(lesson.id);
          final currentLesson = currentTopic.lessons.singleWhere(
            (l) => l.id == lesson.id,
          );
          expect(currentLesson.content, lesson.content);
          expect(currentLesson.example, lesson.example);
          for (final question in lesson.questions) {
            oldIds.add(question.id);
            final currentQuestion = currentLesson.questions.singleWhere(
              (q) => q.id == question.id,
            );
            expect(currentQuestion.prompt, question.prompt);
            expect(currentQuestion.options, question.options);
            expect(currentQuestion.correctIndex, question.correctIndex);
            expect(currentQuestion.explanation, question.explanation);
          }
        }
      }
    }
    oldIds.addAll(old_gamification.Gamification.achievements.map((a) => a.id));
    oldIds.addAll(old_gamification.Gamification.themes.map((t) => t.id));
    expect(oldIds, hasLength(68));
    expect(oldIds.difference(currentIds), isEmpty);
  });

  for (final fixture in {
    'complete': tspCompleteProgress,
    'mixed': tspMixedProgress,
  }.entries) {
    test(
      'ORIGIN ${fixture.key}: Sprint 2 writes and accepts exact progress bytes',
      () async {
        final preferences = _Preferences();
        final store = old_progress.LocalProgressStore(preferences: preferences);
        await store.save(old_progress.ProgressSnapshot.decode(fixture.value));
        expect(preferences.values, {tspProgressKey: fixture.value});
        final controller = old_learning.LearningController(
          modules: old_catalog.catalog,
          store: store,
        );
        addTearDown(controller.dispose);
        await controller.load();
        expect(controller.ready, isTrue, reason: controller.loadError);
        expect(controller.points, fixture.key == 'complete' ? 100 : 10);
        expect(preferences.writes, [tspProgressKey]);
        expect(preferences.values[tspProgressKey], fixture.value);
      },
    );
  }

  test(
    'ORIGIN notes: Sprint 2 writes exact text, dates, IDs and key',
    () async {
      final preferences = _Preferences();
      final data = (jsonDecode(tspNotes) as Map)['notes'] as Map;
      final notes = {
        for (final entry in data.entries)
          entry.key as String: old_notes.PersonalNote(
            lessonId: entry.key as String,
            text: entry.value['text'] as String,
            modifiedAt: DateTime.parse(entry.value['modifiedAt'] as String),
          ),
      };
      await old_notes.LocalNotesStore(preferences: preferences).save(notes);
      expect(preferences.values, {tspNotesKey: tspNotes});
      expect(notes.keys.toSet(), {
        for (final module in old_catalog.catalog)
          for (final topic in module.topics)
            for (final lesson in topic.lessons) lesson.id,
      });
    },
  );

  test(
    'ORIGIN reminder: Sprint 2 writes both original configurations exactly',
    () async {
      final preferences = _Preferences();
      final store = old_reminder.LocalReminderStore(preferences: preferences);
      for (final raw in [tspEnabledReminder, tspDisabledReminder]) {
        await store.save(
          old_reminder.ReminderSettings.fromJson(jsonDecode(raw)),
        );
        expect(preferences.values, {tspReminderKey: raw});
      }
    },
  );
}
