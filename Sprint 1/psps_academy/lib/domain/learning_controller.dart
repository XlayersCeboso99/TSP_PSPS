import 'package:flutter/foundation.dart';

import '../data/progress_store.dart';
import 'course.dart';

class LearningController extends ChangeNotifier {
  LearningController({required this.modules, required this.store});
  final List<CourseModule> modules;
  final ProgressStore store;
  ProgressSnapshot _state = ProgressSnapshot();
  bool ready = false;
  bool saving = false;
  String? loadError;
  String? saveError;

  Iterable<Lesson> get lessons =>
      modules.expand((m) => m.topics).expand((t) => t.lessons);
  Iterable<Question> get questions => lessons.expand((l) => l.questions);
  Iterable<Practice> get practices =>
      modules.expand((m) => m.topics).map((t) => t.practice);
  int get answeredCount => questions.where((q) => answerFor(q) != null).length;
  int get questionCount => questions.length;
  double get progress => questionCount == 0 ? 0 : answeredCount / questionCount;
  int get completedPractices => practices.where(practiceCompleted).length;
  // Demonstration rules only. Replace after D-02 is validated by the team.
  static const demoPointsPerPractice = 10;
  int get points => completedPractices * demoPointsPerPractice;
  int? answerFor(Question question) => _state.answers[question.id];
  List<int> orderFor(Practice practice) => _state.practices[practice.id] ?? [];

  bool practiceCompleted(Practice practice) {
    final order = orderFor(practice);
    return order.length == practice.steps.length &&
        List.generate(order.length, (i) => order[i] == i).every((v) => v);
  }

  ProgressStatus statusForQuestions(Iterable<Question> questions) {
    final all = questions.toList();
    final answered = all.where((q) => answerFor(q) != null).length;
    if (answered == 0) return ProgressStatus.notStarted;
    return answered == all.length
        ? ProgressStatus.completed
        : ProgressStatus.inProgress;
  }

  ProgressStatus lessonStatus(Lesson lesson) =>
      statusForQuestions(lesson.questions);
  ProgressStatus topicStatus(Topic topic) =>
      statusForQuestions(topic.lessons.expand((l) => l.questions));
  ProgressStatus moduleStatus(CourseModule module) =>
      statusForQuestions(module.questions);

  Future<void> load() async {
    ready = false;
    loadError = null;
    notifyListeners();
    try {
      final state = await store.load();
      // Reject inconsistent data without silently discarding the saved copy.
      for (final q in questions) {
        final answer = state.answers[q.id];
        if (answer != null && (answer < 0 || answer >= q.options.length)) {
          throw const FormatException('Respuesta fuera del catálogo');
        }
      }
      for (final p in practices) {
        final order = state.practices[p.id] ?? [];
        if (order.length > p.steps.length ||
            order.toSet().length != order.length ||
            order.any((i) => i < 0 || i >= p.steps.length)) {
          throw const FormatException('Actividad fuera del catálogo');
        }
      }
      _state = state;
      ready = true;
    } catch (_) {
      loadError = 'No pudimos recuperar tu avance. Tus datos guardados se conservan. Intenta de nuevo.';
    }
    notifyListeners();
  }

  Future<bool> answer(Question question, int index) async {
    if (!questions.any((q) => identical(q, question)) ||
        index < 0 ||
        index >= question.options.length) {
      return false;
    }
    if (answerFor(question) != null) return true;
    return _commit(
      ProgressSnapshot(
        answers: {..._state.answers, question.id: index},
        practices: _state.practices,
      ),
    );
  }

  Future<bool> saveOrder(Practice practice, List<int> order) async {
    if (!practices.any((p) => identical(p, practice)) ||
        order.length > practice.steps.length ||
        order.toSet().length != order.length ||
        order.any((i) => i < 0 || i >= practice.steps.length)) {
      return false;
    }
    if (practiceCompleted(practice)) return true;
    return _commit(
      ProgressSnapshot(
        answers: _state.answers,
        practices: {..._state.practices, practice.id: order},
      ),
    );
  }

  Future<bool> _commit(ProgressSnapshot next) async {
    if (!ready || saving) return false;
    saving = true;
    saveError = null;
    notifyListeners();
    try {
      // Publish progress only after the storage operation succeeds.
      await store.save(next);
      _state = next;
      return true;
    } catch (_) {
      saveError = 'No se pudo guardar el cambio. Intenta de nuevo.';
      return false;
    } finally {
      saving = false;
      notifyListeners();
    }
  }
}
