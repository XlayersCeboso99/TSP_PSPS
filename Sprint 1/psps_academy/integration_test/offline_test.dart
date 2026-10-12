import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:psps/data/catalog.dart';
import 'package:psps/data/progress_store.dart';
import 'package:psps/domain/learning_controller.dart';
import 'package:psps/domain/course.dart';
import 'package:psps/ui/app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('RF08: real device storage survives controller recreation', (
    tester,
  ) async {
    const testKey = 'psps.integration.sprint1';
    final preferences = SharedPreferencesAsync();
    await preferences.remove(testKey);
    addTearDown(() => preferences.remove(testKey));
    final store = LocalProgressStore(preferences: preferences, key: testKey);
    final first = LearningController(modules: catalog, store: store);
    await first.load();
    for (final q in catalog.first.questions) {
      await first.answer(q, (q.correctIndex + 1) % q.options.length);
    }
    await first.saveOrder(catalog.first.topics.first.practice, [0, 1, 2]);
    await tester.pumpWidget(PspsApp(controller: first));
    await tester.pumpAndSettle();
    expect(first.moduleStatus(catalog.first), ProgressStatus.completed);
    await tester.pumpWidget(const SizedBox.shrink());
    first.dispose();
    final restored = LearningController(
      modules: catalog,
      store: LocalProgressStore(
        preferences: SharedPreferencesAsync(),
        key: testKey,
      ),
    );
    await restored.load();
    await tester.pumpWidget(PspsApp(controller: restored));
    await tester.pumpAndSettle();
    expect(restored.moduleStatus(catalog.first), ProgressStatus.completed);
    expect(restored.answeredCount, catalog.first.questions.length);
    expect(restored.points, 10);
    expect(find.text('PSPS Academy'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
