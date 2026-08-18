import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_learning_app/core/language_provider.dart';
import 'package:flutter_learning_app/widgets/tracing_canvas.dart';

class LettersScreen extends StatefulWidget {
  const LettersScreen({Key? key}) : super(key: key);

  @override
  State<LettersScreen> createState() => _LettersScreenState();
}

class _LettersScreenState extends State<LettersScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final letters = langProvider.step1Letters;
    final currentChar = letters.isNotEmpty ? letters[currentIndex] : '';

    return Scaffold(
      backgroundColor: const Color(0xFF1E122A),
      appBar: AppBar(
        title: Text(langProvider.step1Title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: letters.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SizedBox(
                  height: 64,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: letters.length,
                    itemBuilder: (context, index) {
                      final isSel = index == currentIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() => currentIndex = index);
                          langProvider.audioService.explainError(customMessage: letters[index]);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          decoration: BoxDecoration(
                            color: isSel ? const Color(0xFF6C5CE7) : Colors.white12,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: isSel ? Colors.white : Colors.transparent),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            letters[index],
                            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: TracingCanvas(key: ValueKey(currentChar), charToTrace: currentChar),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C5CE7),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () => langProvider.audioService.explainError(customMessage: currentChar),
                    icon: const Icon(Icons.volume_up, size: 24),
                    label: const Text('Listen Pronunciation', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
    );
  }
}
