enum ProgressStatus {
  notStarted('Sin iniciar'),
  inProgress('En progreso'),
  completed('Completado');

  const ProgressStatus(this.label);
  final String label;
}

class Question {
  const Question({
    required this.id,
    required this.prompt,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
  final String id;
  final String prompt;
  final List<String> options;
  final int correctIndex;
  final String explanation;
}

class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.content,
    required this.example,
    required this.questions,
  });
  final String id;
  final String title;
  final String content;
  final String example;
  final List<Question> questions;
}

class Practice {
  const Practice({
    required this.id,
    required this.title,
    required this.instruction,
    required this.steps,
  });
  final String id;
  final String title;
  final String instruction;
  // Canonical order; the interface presents these in a different order.
  final List<String> steps;
}

class Topic {
  const Topic({
    required this.id,
    required this.title,
    required this.lessons,
    required this.practice,
  });
  final String id;
  final String title;
  final List<Lesson> lessons;
  final Practice practice;
}

class CourseModule {
  const CourseModule({
    required this.id,
    required this.title,
    required this.area,
    required this.description,
    required this.topics,
  });
  final String id;
  final String title;
  final String area;
  final String description;
  final List<Topic> topics;
  Iterable<Question> get questions =>
      topics.expand((t) => t.lessons).expand((l) => l.questions);
}
