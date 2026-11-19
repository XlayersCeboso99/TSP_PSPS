import 'package:flutter_test/flutter_test.dart';
import 'package:psps/data/catalog.dart';
import 'package:psps/data/progress_store.dart';
import 'package:psps/domain/learning_controller.dart';

import 'support.dart';

void main() {
  test('CU07: failed and successful review preserve every reward and theme', () async {
    final store = MemoryStore();
    final controller = LearningController(modules: catalog, store: store);
    await controller.load();
    final module = catalog.first;
    final question = module.questions.first;
    final activity = module.topics.first.practice;
    final wrong = (question.correctIndex + 1) % question.options.length;
    await controller.answer(question, wrong);
    await controller.saveOrder(
      activity,
      List.generate(activity.steps.length, (i) => i),
    );
    expect(controller.unlockedThemes, contains('U-01'));
    expect(await controller.selectTheme('U-01'), isTrue);
    final before = ProgressSnapshot.decode(store.raw!);
    final unlocked = Set<String>.from(controller.unlockedThemes);

    for (final answer in [wrong, question.correctIndex]) {
      expect(await controller.reviewAnswer(question, answer), isTrue);
      final after = ProgressSnapshot.decode(store.raw!);
      expect(after.answers, before.answers);
      expect(after.practices, before.practices);
      expect(after.points, before.points);
      expect(after.rewardedPractices, before.rewardedPractices);
      expect(after.achievements, before.achievements);
      expect(after.selectedTheme, before.selectedTheme);
      expect(controller.unlockedThemes, unlocked);
      expect(controller.newAchievements, isEmpty);
      expect(controller.newThemes, isEmpty);
    }
    final restored = LearningController(modules: catalog, store: store);
    await restored.load();
    expect(restored.ready, isTrue);
    expect(restored.needsReview(question), isFalse);
    expect(restored.points, before.points);
    expect(restored.earnedAchievements, before.achievements);
    expect(restored.selectedTheme, 'U-01');
    expect(restored.unlockedThemes, unlocked);
  });
}
