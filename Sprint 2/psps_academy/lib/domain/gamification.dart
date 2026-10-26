import 'course.dart';

class Achievement {
  const Achievement(this.id, this.name, this.condition);
  final String id;
  final String name;
  final String condition;
}

class VisualTheme {
  const VisualTheme(this.id, this.name, this.condition);
  final String id;
  final String name;
  final String condition;
}

abstract final class Gamification {
  static const pointsPerPractice = 10;
  static const achievements = [
    Achievement(
      'L-01',
      'Primer paso',
      'Responde tu primera pregunta, correcta o incorrectamente.',
    ),
    Achievement(
      'L-02',
      'Subtema completo',
      'Responde todas las preguntas de un subtema.',
    ),
    Achievement('L-03', 'Manos a la obra', 'Completa tu primera actividad.'),
    Achievement(
      'L-04',
      'Práctica constante',
      'Completa 5 actividades distintas.',
    ),
    Achievement(
      'L-05',
      'Todas las prácticas',
      'Completa todas las actividades del catálogo.',
    ),
    Achievement(
      'L-06',
      'Estructuras en orden',
      'Completa Estructuras y algoritmos.',
    ),
    Achievement(
      'L-07',
      'Mente orientada a objetos',
      'Completa Programación y objetos.',
    ),
    Achievement(
      'L-08',
      'Datos bien relacionados',
      'Completa Datos y relaciones.',
    ),
    Achievement(
      'L-09',
      'Pensando en las personas',
      'Completa Diseño para las personas.',
    ),
    Achievement(
      'L-11',
      'Recorrido completo',
      'Completa todos los módulos del catálogo.',
    ),
  ];
  static const themes = [
    VisualTheme('U-00', 'Bosque', 'Disponible desde el inicio.'),
    VisualTheme(
      'U-01',
      'Océano',
      'Obtén Manos a la obra: completa tu primera actividad.',
    ),
    VisualTheme('U-02', 'Atardecer', 'Completa cualquier módulo.'),
    VisualTheme(
      'U-03',
      'Noche',
      'Obtén Recorrido completo: completa todos los módulos.',
    ),
  ];

  static bool complete(Practice p, Map<String, List<int>> orders) {
    final order = orders[p.id] ?? [];
    return p.steps.isNotEmpty &&
        order.length == p.steps.length &&
        List.generate(order.length, (i) => order[i] == i).every((v) => v);
  }

  static Set<String> completedPracticeIds(
    List<CourseModule> modules,
    Map<String, List<int>> orders,
  ) => {
    for (final m in modules)
      for (final t in m.topics)
        if (complete(t.practice, orders)) t.practice.id,
  };

  static Set<String> eligible(
    List<CourseModule> modules,
    Map<String, int> answers,
    Map<String, List<int>> orders,
  ) {
    bool done(Iterable<Question> questions) =>
        questions.isNotEmpty &&
        questions.every((q) => answers.containsKey(q.id));
    final lessons = modules.expand((m) => m.topics).expand((t) => t.lessons);
    final activities = modules
        .expand((m) => m.topics)
        .map((t) => t.practice)
        .where((p) => p.steps.isNotEmpty);
    final completed = completedPracticeIds(modules, orders);
    return {
      if (lessons
          .expand((l) => l.questions)
          .any((q) => answers.containsKey(q.id)))
        'L-01',
      if (lessons.any((l) => done(l.questions))) 'L-02',
      if (completed.isNotEmpty) 'L-03',
      if (completed.length >= 5) 'L-04',
      if (activities.isNotEmpty && completed.length == activities.length)
        'L-05',
      for (final (moduleId, achievementId) in [
        ('m1', 'L-06'),
        ('m2', 'L-07'),
        ('m3', 'L-08'),
        ('m4', 'L-09'),
      ])
        if (modules.any((m) => m.id == moduleId && done(m.questions)))
          achievementId,
      if (modules.isNotEmpty && modules.every((m) => done(m.questions))) 'L-11',
    };
  }

  static Set<String> unlocked(Iterable<String> earned) => {
    'U-00',
    if (earned.contains('L-03')) 'U-01',
    if (['L-06', 'L-07', 'L-08', 'L-09'].any(earned.contains)) 'U-02',
    if (earned.contains('L-11')) 'U-03',
  };
}
