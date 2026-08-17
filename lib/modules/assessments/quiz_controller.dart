import 'dart:math';

class QuizItem {
  final String id;
  final String word;
  final String imagePath;
  final List<String> distractors;
  final String? explanationText;

  QuizItem({
    required this.id,
    required this.word,
    required this.imagePath,
    required this.distractors,
    this.explanationText,
  });
}

class QuizQuestion {
  final QuizItem item;
  final List<String> options;
  final String correctAnswer;

  QuizQuestion({
    required this.item,
    required this.options,
    required this.correctAnswer,
  });
}

class AssessmentController {
  final List<QuizItem> allItems;
  final Set<String> _usedItemIds = {};
  List<QuizItem> _currentSessionPool = [];

  AssessmentController({required this.allItems}) {
    _resetOrShufflePool();
  }

  void _resetOrShufflePool() {
    if (_usedItemIds.length >= allItems.length) {
      _usedItemIds.clear();
    }
    _currentSessionPool = allItems
        .where((item) => !_usedItemIds.contains(item.id))
        .toList();
    _currentSessionPool.shuffle(Random());
  }

  QuizQuestion? getNextQuestion(int totalOptions) {
    if (_currentSessionPool.isEmpty) {
      _resetOrShufflePool();
    }

    final targetItem = _currentSessionPool.removeLast();
    _usedItemIds.add(targetItem.id);

    List<String> options = [targetItem.word];
    List<String> availableDistractors = List.from(targetItem.distractors)..shuffle(Random());

    for (var distractor in availableDistractors) {
      if (options.length < totalOptions && !options.contains(distractor)) {
        options.add(distractor);
      }
    }

    options.shuffle(Random());

    return QuizQuestion(
      item: targetItem,
      options: options,
      correctAnswer: targetItem.word,
    );
  }
}
