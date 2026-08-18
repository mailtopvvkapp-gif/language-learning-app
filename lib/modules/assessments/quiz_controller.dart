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

  QuizQuestion({required this.item, required this.options, required this.correctAnswer});
}

class AssessmentController {
  final List<QuizItem> allItems;
  final Set<String> _usedItemIds = {};
  List<QuizItem> _currentSessionPool = [];

  AssessmentController({required this.allItems}) {
    _resetOrShufflePool();
  }

  void _resetOrShufflePool() {
    if (_usedItemIds.length >= allItems.length) _usedItemIds.clear();
    _currentSessionPool = allItems.where((i) => !_usedItemIds.contains(i.id)).toList()..shuffle(Random());
  }

  QuizQuestion? getNextQuestion(int totalOptions) {
    if (_currentSessionPool.isEmpty) _resetOrShufflePool();
    final target = _currentSessionPool.removeLast();
    _usedItemIds.add(target.id);

    List<String> opts = [target.word];
    List<String> dist = List.from(target.distractors)..shuffle(Random());

    for (var d in dist) {
      if (opts.length < totalOptions && !opts.contains(d)) opts.add(d);
    }
    opts.shuffle(Random());

    return QuizQuestion(item: target, options: opts, correctAnswer: target.word);
  }
}
