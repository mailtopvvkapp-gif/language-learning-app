import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_learning_app/core/language_provider.dart';
import 'package:flutter_learning_app/modules/assessments/quiz_controller.dart';
import 'package:flutter_learning_app/widgets/rich_image_card.dart';

class QuizScreen extends StatefulWidget {
  final List<QuizItem> items;
  final String quizTitle;

  const QuizScreen({Key? key, required this.items, required this.quizTitle}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late AssessmentController _controller;
  QuizQuestion? _currentQuestion;
  String? _selectedOption;
  bool _isAnswerChecked = false;

  @override
  void initState() {
    super.initState();
    _controller = AssessmentController(allItems: widget.items);
    _loadNextQuestion();
  }

  void _loadNextQuestion() {
    setState(() {
      _selectedOption = null;
      _isAnswerChecked = false;
      _currentQuestion = _controller.getNextQuestion(4);
    });
  }

  void _checkAnswer(String option) async {
    if (_isAnswerChecked || _currentQuestion == null) return;
    final provider = Provider.of<LanguageProvider>(context, listen: false);

    setState(() {
      _selectedOption = option;
      _isAnswerChecked = true;
    });

    if (option != _currentQuestion!.correctAnswer) {
      final msg = _currentQuestion!.item.explanationText ?? 'తప్పు సమాధానం. సరైన పదం ${_currentQuestion!.correctAnswer}.';
      await provider.audioService.explainError(customMessage: msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestion == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF1E122A),
        appBar: AppBar(title: Text(widget.quizTitle), backgroundColor: Colors.transparent),
        body: const Center(child: Text('అన్ని ప్రశ్నలు పూర్తయ్యాయి!', style: TextStyle(color: Colors.white, fontSize: 18))),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1E122A),
      appBar: AppBar(title: Text(widget.quizTitle), backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Center(
                child: RichImageCard(word: _currentQuestion!.correctAnswer, size: 180),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 4,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.2,
                children: _currentQuestion!.options.map((option) {
                  Color btnColor = Colors.white.withOpacity(0.12);
                  if (_isAnswerChecked) {
                    if (option == _currentQuestion!.correctAnswer) {
                      btnColor = Colors.greenAccent.shade700;
                    } else if (option == _selectedOption) {
                      btnColor = Colors.redAccent.shade700;
                    }
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: btnColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () => _checkAnswer(option),
                    child: Text(option, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  );
                }).toList(),
              ),
            ),
            if (_isAnswerChecked)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5CE7),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _loadNextQuestion,
                child: const Text('తర్వాతి ప్రశ్న (Next) ➔', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
          ],
        ),
      ),
    );
  }
}
