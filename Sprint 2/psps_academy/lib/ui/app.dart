import 'package:flutter/material.dart';

import '../domain/course.dart';
import '../domain/learning_controller.dart';
import '../domain/content_search.dart';
import '../domain/gamification.dart';

part 'review_screens.dart';
part 'sprint2_screens.dart';

const forest = Color(0xFF164E3C);
const cream = Color(0xFFF6F7F2);
const ink = Color(0xFF182C25);

class PspsApp extends StatelessWidget {
  const PspsApp({super.key, required this.controller});
  final LearningController controller;
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: controller,
    builder: (context, _) => MaterialApp(
      title: 'PSPS Academy · Aprende software',
      debugShowCheckedModeBanner: false,
      theme: academyTheme(controller.selectedTheme),
      home: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          if (controller.ready) return HomeScreen(controller: controller);
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: controller.loadError == null
                      ? const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 20),
                            Text('Preparando tu recorrido…'),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.cloud_off_rounded, size: 48),
                            const SizedBox(height: 20),
                            Text(
                              controller.loadError!,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            FilledButton(
                              onPressed: controller.load,
                              child: const Text('Reintentar'),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

ThemeData academyTheme(String id) {
  final seed = switch (id) {
    'U-01' => const Color(0xFF155C8A),
    'U-02' => const Color(0xFF9A431E),
    'U-03' => const Color(0xFF8DB7F5),
    _ => forest,
  };
  final dark = id == 'U-03';
  final scheme = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: dark ? Brightness.dark : Brightness.light,
    primary: dark ? null : seed,
    surface: dark
        ? const Color(0xFF111C2C)
        : id == 'U-00'
        ? cream
        : null,
  );
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: scheme.surface,
    colorScheme: scheme,
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      centerTitle: false,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(48, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(48, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
  );
}

Color statusColor(ProgressStatus state) => switch (state) {
  ProgressStatus.notStarted => const Color(0xFF68716E),
  ProgressStatus.inProgress => const Color(0xFFAA5700),
  ProgressStatus.completed => forest,
};

class StatusBadge extends StatelessWidget {
  const StatusBadge(this.status, {super.key});
  final ProgressStatus status;
  @override
  Widget build(BuildContext context) {
    final badgeColor = Theme.of(context).brightness == Brightness.dark
        ? switch (status) {
            ProgressStatus.notStarted => const Color(0xFFC2CBC7),
            ProgressStatus.inProgress => const Color(0xFFFFBD7A),
            ProgressStatus.completed => const Color(0xFF8DD9A3),
          }
        : statusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: .10),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            status == ProgressStatus.completed
                ? Icons.check_circle_rounded
                : status == ProgressStatus.inProgress
                ? Icons.timelapse_rounded
                : Icons.circle_outlined,
            color: badgeColor,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            status.label,
            style: TextStyle(
              color: badgeColor,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class ScreenFrame extends StatelessWidget {
  const ScreenFrame({
    super.key,
    required this.title,
    required this.controller,
    required this.content,
  });
  final String title;
  final LearningController controller;
  final List<Widget> Function(BuildContext) content;
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: controller,
    builder: (context, _) => Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
              children: content(context),
            ),
          ),
        ),
      ),
    ),
  );
}

void openScreen(BuildContext context, Widget screen) =>
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => screen));

Future<void> reportSave(
  BuildContext context,
  Future<bool> operation, {
  LearningController? controller,
}) async {
  final ok = await operation;
  if (!ok && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'No se pudo guardar. Intenta de nuevo; tu avance anterior se conserva.',
        ),
      ),
    );
  } else if (ok &&
      context.mounted &&
      controller != null &&
      (controller.newAchievements.isNotEmpty ||
          controller.newThemes.isNotEmpty)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          [
            if (controller.newAchievements.isNotEmpty)
              'Logros obtenidos: ${controller.newAchievements.map((a) => a.name).join(', ')}.',
            if (controller.newThemes.isNotEmpty)
              'Temas disponibles: ${controller.newThemes.map((t) => t.name).join(', ')}.',
          ].join(' '),
        ),
      ),
    );
  }
}

Widget caption(String text) => Padding(
  padding: const EdgeInsets.only(bottom: 14),
  child: Text(text, style: const TextStyle(height: 1.5)),
);
Widget heading(String text) => Padding(
  padding: const EdgeInsets.only(bottom: 12),
  child: Text(
    text,
    style: const TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w800,
      height: 1.2,
    ),
  ),
);
Widget panel(List<Widget> children, {Color? color}) => Builder(
  builder: (context) => Theme(
    data: color == null ? Theme.of(context) : academyTheme('U-00'),
    child: Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    ),
  ),
);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.controller});
  final LearningController controller;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tab = 0;
  @override
  Widget build(BuildContext context) {
    final c = widget.controller;
    return AnimatedBuilder(
      animation: c,
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.hub_rounded, color: forest),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  'PSPS Academy',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'Buscar contenidos',
              icon: const Icon(Icons.search),
              onPressed: () => openScreen(context, SearchScreen(controller: c)),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Tooltip(
                    message: 'Disponible sin conexión',
                    child: Icon(Icons.offline_bolt_outlined, size: 18),
                  ),
                  if (MediaQuery.sizeOf(context).width >= 500) ...[
                    const SizedBox(width: 4),
                    const Text('Sin conexión', style: TextStyle(fontSize: 12)),
                  ],
                ],
              ),
            ),
          ],
        ),
        body: SafeArea(
          top: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
                children: tab == 0
                    ? _modules(context, c)
                    : _progress(context, c),
              ),
            ),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: tab,
          onDestinationSelected: (index) => setState(() => tab = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.grid_view_rounded),
              label: 'Módulos',
            ),
            NavigationDestination(
              icon: Icon(Icons.route_rounded),
              label: 'Mi progreso',
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _modules(BuildContext context, LearningController c) => [
    Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF244669)
            : Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TU RECORRIDO EMPIEZA AQUÍ',
            style: TextStyle(
              color: Color(0xFFD3ED9B),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Aprende software.\nPaso a paso.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              height: 1.12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Explora ideas, prueba lo que sabes y construye tu recorrido.',
            style: TextStyle(color: Color(0xFFE1EBE3), height: 1.5),
          ),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: c.progress,
              minHeight: 7,
              color: const Color(0xFFD3ED9B),
              backgroundColor: Colors.white24,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${c.answeredCount} de ${c.questionCount} preguntas recorridas',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    ),
    const SizedBox(height: 24),
    FeatureLinks(controller: c),
    heading('Elige tu próximo paso'),
    caption('4 módulos · 10 temas · A tu ritmo'),
    for (var i = 0; i < c.modules.length; i++)
      _moduleCard(context, c, c.modules[i], i),
    const SizedBox(height: 8),
    const Text(
      'Aprende y practica sin conexión · Tu avance se guarda en este dispositivo',
      style: TextStyle(fontSize: 12, color: Color(0xFF596A63)),
      textAlign: TextAlign.center,
    ),
  ];

  Widget _moduleCard(
    BuildContext context,
    LearningController c,
    CourseModule m,
    int i,
  ) {
    const icons = [
      Icons.account_tree_outlined,
      Icons.data_object_rounded,
      Icons.storage_rounded,
      Icons.touch_app_outlined,
    ];
    final done = m.questions.where((q) => c.answerFor(q) != null).length;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () =>
              openScreen(context, ModuleScreen(controller: c, module: m)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE2E7DF)),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F4E8),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(icons[i], color: forest),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        'MÓDULO 0${i + 1}',
                        style: const TextStyle(
                          fontSize: 11,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_rounded, color: forest),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  m.title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(m.area, style: const TextStyle()),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    StatusBadge(c.moduleStatus(m)),
                    Text(
                      '${m.topics.length} temas · $done/${m.questions.length} preguntas',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _progress(BuildContext context, LearningController c) => [
    FeatureLinks(controller: c),
    heading('Cada paso cuenta.'),
    caption(
      'Tu avance depende de las preguntas respondidas, también cuando te equivocas.',
    ),
    panel([
      Text(
        '${(c.progress * 100).round()}%',
        style: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w900,
          color: forest,
        ),
      ),
      const SizedBox(height: 8),
      LinearProgressIndicator(value: c.progress, minHeight: 8),
      const SizedBox(height: 14),
      Text('${c.answeredCount} de ${c.questionCount} preguntas respondidas'),
      const SizedBox(height: 8),
      Text(
        '${c.completedPractices} actividades realizadas · ${c.points} puntos de práctica',
      ),
    ]),
    const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        StatusBadge(ProgressStatus.notStarted),
        StatusBadge(ProgressStatus.inProgress),
        StatusBadge(ProgressStatus.completed),
      ],
    ),
    const SizedBox(height: 22),
    for (final m in c.modules)
      panel([
        Text(
          m.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        for (final t in m.topics)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(t.title),
            subtitle: Text(c.topicStatus(t).label),
            leading: Icon(
              c.topicStatus(t) == ProgressStatus.completed
                  ? Icons.check_circle_rounded
                  : Icons.circle_outlined,
              color: statusColor(c.topicStatus(t)),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => openScreen(
              context,
              TopicScreen(controller: c, module: m, topic: t),
            ),
          ),
      ]),
  ];
}

class ModuleScreen extends StatelessWidget {
  const ModuleScreen({
    super.key,
    required this.controller,
    required this.module,
  });
  final LearningController controller;
  final CourseModule module;
  @override
  Widget build(BuildContext context) => ScreenFrame(
    title: 'Recorrido del módulo',
    controller: controller,
    content: (context) => [
      caption(module.area),
      heading(module.title),
      caption(module.description),
      StatusBadge(controller.moduleStatus(module)),
      ReviewEntry(controller: controller, module: module),
      const SizedBox(height: 24),
      if (controller.moduleStatus(module) == ProgressStatus.completed)
        panel([
          const Icon(Icons.verified_rounded, color: forest, size: 36),
          const SizedBox(height: 10),
          heading('¡Módulo completado!'),
          const Text(
            'Respondiste todas sus preguntas. Puedes volver a consultar cualquier tema.',
          ),
        ], color: const Color(0xFFEAF1DF)),
      for (final topic in module.topics)
        panel([
          Text(
            topic.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          StatusBadge(controller.topicStatus(topic)),
          const SizedBox(height: 14),
          for (final lesson in topic.lessons)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.menu_book_rounded,
                color: statusColor(controller.lessonStatus(lesson)),
              ),
              title: Text(lesson.title),
              subtitle: Text(controller.lessonStatus(lesson).label),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => openScreen(
                context,
                TopicScreen(
                  controller: controller,
                  module: module,
                  topic: topic,
                ),
              ),
            ),
        ]),
      caption(
        'Leer no cambia tu avance. Responder las preguntas sí. Las actividades son opcionales.',
      ),
    ],
  );
}

class TopicScreen extends StatelessWidget {
  const TopicScreen({
    super.key,
    required this.controller,
    required this.module,
    required this.topic,
  });
  final LearningController controller;
  final CourseModule module;
  final Topic topic;
  @override
  Widget build(BuildContext context) => ScreenFrame(
    title: topic.title,
    controller: controller,
    content: (context) => [
      caption('${module.title} / ${topic.title}'),
      heading('Explora el tema'),
      StatusBadge(controller.topicStatus(topic)),
      ReviewEntry(controller: controller, module: module, topic: topic),
      const SizedBox(height: 24),
      for (final lesson in topic.lessons)
        panel([
          Text(
            lesson.title,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          StatusBadge(controller.lessonStatus(lesson)),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => openScreen(
                context,
                LessonScreen(
                  controller: controller,
                  module: module,
                  topic: topic,
                  lesson: lesson,
                ),
              ),
              icon: const Icon(Icons.menu_book_outlined),
              label: const Text('Estudiar subtema'),
            ),
          ),
        ]),
      panel([
        const Row(
          children: [
            Icon(Icons.extension_outlined, color: forest),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Ponlo en práctica',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        caption('Actividad opcional. No afecta la finalización de este tema.'),
        Text(topic.practice.title),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => openScreen(
              context,
              PracticeScreen(controller: controller, topic: topic),
            ),
            child: Text(
              controller.practiceCompleted(topic.practice)
                  ? 'Consultar actividad realizada'
                  : 'Realizar actividad',
            ),
          ),
        ),
      ]),
    ],
  );
}

class LessonScreen extends StatefulWidget {
  const LessonScreen({
    super.key,
    required this.controller,
    required this.module,
    required this.topic,
    required this.lesson,
  });
  final LearningController controller;
  final CourseModule module;
  final Topic topic;
  final Lesson lesson;
  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int page = 0;
  @override
  Widget build(BuildContext context) => ScreenFrame(
    title: widget.lesson.title,
    controller: widget.controller,
    content: (context) => [
      caption('${widget.topic.title} / ${widget.lesson.title}'),
      Wrap(
        spacing: 12,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          StatusBadge(widget.controller.lessonStatus(widget.lesson)),
          Text('Contenido ${page + 1} de 2'),
        ],
      ),
      const SizedBox(height: 24),
      panel([
        Icon(
          page == 0 ? Icons.lightbulb_outline_rounded : Icons.code_rounded,
          color: forest,
          size: 42,
        ),
        const SizedBox(height: 20),
        heading(page == 0 ? widget.lesson.title : 'Un ejemplo para entenderlo'),
        Text(
          page == 0 ? widget.lesson.content : widget.lesson.example,
          style: TextStyle(
            fontSize: 17,
            height: 1.7,
            fontFamily: page == 1 ? 'monospace' : null,
          ),
        ),
      ]),
      Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: page == 0 ? null : () => setState(() => page--),
              child: const Text('Anterior'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: page == 1 ? null : () => setState(() => page++),
              child: const Text('Siguiente'),
            ),
          ),
        ],
      ),
      const SizedBox(height: 18),
      FilledButton.icon(
        onPressed: () => openScreen(
          context,
          QuestionsScreen(
            controller: widget.controller,
            module: widget.module,
            topic: widget.topic,
            lesson: widget.lesson,
          ),
        ),
        icon: const Icon(Icons.quiz_outlined),
        label: const Text('Ir a preguntas'),
      ),
      const SizedBox(height: 20),
      caption(
        'No necesitas acertar para avanzar. Lee la retroalimentación y sigue aprendiendo.',
      ),
    ],
  );
}

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.controller,
    required this.module,
    required this.topic,
    required this.lesson,
  });
  final LearningController controller;
  final CourseModule module;
  final Topic topic;
  final Lesson lesson;
  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late int index;
  int? selected;
  @override
  void initState() {
    super.initState();
    final next = widget.lesson.questions.indexWhere(
      (q) => widget.controller.answerFor(q) == null,
    );
    index = next < 0 ? 0 : next;
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.controller;
    final l = widget.lesson;
    final q = l.questions[index];
    return ScreenFrame(
      title: 'Comprueba lo aprendido',
      controller: c,
      content: (context) {
        final saved = c.answerFor(q);
        final isCorrect = saved == q.correctIndex;
        final answered = l.questions
            .where((q) => c.answerFor(q) != null)
            .length;
        return [
          caption('${widget.topic.title} / ${l.title}'),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Pregunta ${index + 1} de ${l.questions.length}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              StatusBadge(c.lessonStatus(l)),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value:
                l.questions.where((q) => c.answerFor(q) != null).length /
                l.questions.length,
            minHeight: 6,
          ),
          const SizedBox(height: 10),
          caption(
            '$answered ${answered == 1 ? 'pregunta respondida' : 'preguntas respondidas'}',
          ),
          heading(q.prompt),
          const SizedBox(height: 8),
          for (var i = 0; i < q.options.length; i++) _option(q, i, saved),
          if (saved != null)
            panel(
              [
                Row(
                  children: [
                    Icon(
                      isCorrect
                          ? Icons.check_circle_rounded
                          : Icons.info_outline_rounded,
                      color: isCorrect ? forest : const Color(0xFFAA5700),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        isCorrect
                            ? '¡Respuesta correcta!'
                            : 'Sigue aprendiendo',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (!isCorrect)
                  Text('Respuesta correcta: ${q.options[q.correctIndex]}'),
                const SizedBox(height: 6),
                Text(q.explanation, style: const TextStyle(height: 1.6)),
                const SizedBox(height: 12),
                const Text(
                  'Esta pregunta ya cuenta para tu avance.',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
              color: isCorrect
                  ? const Color(0xFFEAF1DF)
                  : const Color(0xFFFFF2DF),
            ),
          if (c.lessonStatus(l) == ProgressStatus.completed &&
              index == l.questions.length - 1)
            panel([
              heading('¡Subtema completado!'),
              const Text('Respondiste todas sus preguntas.'),
              const SizedBox(height: 10),
              Text('Tema: ${c.topicStatus(widget.topic).label}'),
              Text('Módulo: ${c.moduleStatus(widget.module).label}'),
            ]),
          if (saved == null)
            FilledButton(
              onPressed: selected == null || c.saving
                  ? null
                  : () => reportSave(
                      context,
                      c.answer(q, selected!),
                      controller: c,
                    ),
              child: Text(c.saving ? 'Guardando…' : 'Comprobar'),
            )
          else if (index < l.questions.length - 1)
            FilledButton(
              onPressed: () => setState(() {
                index++;
                selected = null;
              }),
              child: const Text('Siguiente pregunta'),
            )
          else
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Volver al contenido'),
            ),
          const SizedBox(height: 12),
          if (index > 0)
            TextButton(
              onPressed: c.saving
                  ? null
                  : () => setState(() {
                      index--;
                      selected = null;
                    }),
              child: const Text('Pregunta anterior'),
            ),
        ];
      },
    );
  }

  Widget _option(Question q, int i, int? saved) {
    final chosen = (saved ?? selected) == i;
    final showCorrect = saved != null && q.correctIndex == i;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: chosen || showCorrect
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: saved != null || widget.controller.saving
              ? null
              : () => setState(() => selected = i),
          child: Semantics(
            selected: chosen,
            button: true,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: chosen || showCorrect
                      ? forest
                      : const Color(0xFFDCE2DA),
                  width: chosen ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    showCorrect
                        ? Icons.check_circle_outline_rounded
                        : chosen
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: forest,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      q.options[i],
                      style: const TextStyle(fontSize: 16, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({
    super.key,
    required this.controller,
    required this.topic,
  });
  final LearningController controller;
  final Topic topic;
  @override
  Widget build(BuildContext context) => ScreenFrame(
    title: 'Actividad interactiva',
    controller: controller,
    content: (context) {
      final p = topic.practice;
      final order = controller.orderFor(p);
      final complete = controller.practiceCompleted(p);
      final full = order.length == p.steps.length;
      return [
        caption('${topic.title} / Actividad opcional'),
        heading(p.title),
        caption(p.instruction),
        if (!complete)
          caption(
            'Toca los elementos en el orden adecuado. Toca un paso elegido para retirarlo.',
          ),
        panel([
          const Text(
            'TU SECUENCIA',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < p.steps.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: i < order.length
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.surface,
                leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: forest,
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                title: Text(
                  i < order.length
                      ? p.steps[order[i]]
                      : 'Elige el siguiente paso',
                ),
                trailing: i < order.length && !complete
                    ? const Icon(Icons.close_rounded)
                    : null,
                onTap: i >= order.length || complete || controller.saving
                    ? null
                    : () {
                        final next = [...order]..removeAt(i);
                        reportSave(
                          context,
                          controller.saveOrder(p, next),
                          controller: controller,
                        );
                      },
              ),
            ),
        ]),
        if (!complete && !full) ...[
          heading('Elementos disponibles'),
          for (final i in List.generate(p.steps.length, (i) => i).reversed)
            if (!order.contains(i))
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: OutlinedButton(
                  onPressed: controller.saving
                      ? null
                      : () => reportSave(
                          context,
                          controller.saveOrder(p, [...order, i]),
                          controller: controller,
                        ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(p.steps[i], textAlign: TextAlign.center),
                  ),
                ),
              ),
        ],
        if (full && !complete)
          panel([
            const Icon(
              Icons.tips_and_updates_outlined,
              color: Color(0xFFAA5700),
            ),
            const SizedBox(height: 12),
            heading('Revisa la secuencia'),
            const Text(
              'Los pasos todavía no están en el orden esperado. Retira un elemento para acomodarlo otra vez.',
            ),
          ], color: const Color(0xFFFFF2DF)),
        if (complete)
          panel([
            const Icon(Icons.verified_rounded, color: forest, size: 44),
            const SizedBox(height: 12),
            heading('¡Actividad realizada!'),
            const Text('Completaste todos los pasos en el orden esperado.'),
            const SizedBox(height: 14),
            Text(
              '${LearningController.pointsPerPractice} puntos de esta actividad',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: forest,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Se otorgan una sola vez por actividad. Consultarla de nuevo no suma puntos.',
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Volver al tema'),
            ),
          ], color: const Color(0xFFEAF1DF)),
        const SizedBox(height: 10),
        Text(
          '${order.length}/${p.steps.length} pasos elegidos · ${complete ? 'Realizada' : 'Pendiente'}',
        ),
        const SizedBox(height: 10),
        caption('Esta actividad no modifica el progreso de las preguntas.'),
      ];
    },
  );
}
