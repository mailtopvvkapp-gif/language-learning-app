import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_learning_app/core/language_provider.dart';
import 'package:flutter_learning_app/widgets/tracing_canvas.dart';

class GunintaluScreen extends StatefulWidget {
  const GunintaluScreen({Key? key}) : super(key: key);

  @override
  State<GunintaluScreen> createState() => _GunintaluScreenState();
}

class _GunintaluScreenState extends State<GunintaluScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final items = langProvider.step3Gunintalu;
    final currentChar = items.isNotEmpty ? items[currentIndex] : '';

    return Scaffold(
      backgroundColor: const Color(0xFF1E122A),
      appBar: AppBar(
        title: Text(langProvider.step3Title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SizedBox(
                  height: 64,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final isSel = index == currentIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() => currentIndex = index);
                          langProvider.audioService.explainError(customMessage: items[index]);
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
                            items[index],
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
                    ),
                    child: TracingCanvas(key: ValueKey(currentChar), charToTrace: currentChar),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7)),
                    onPressed: () => langProvider.audioService.explainError(customMessage: currentChar),
                    icon: const Icon(Icons.volume_up),
                    label: const Text('Listen Pronunciation'),
                  ),
                ),
              ],
            ),
    );
  }
}
