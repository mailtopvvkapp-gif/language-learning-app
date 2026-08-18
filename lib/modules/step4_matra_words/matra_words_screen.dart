import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_learning_app/core/language_provider.dart';
import 'package:flutter_learning_app/widgets/rich_image_card.dart';

class MatraWordsScreen extends StatelessWidget {
  const MatraWordsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF1E122A),
      appBar: AppBar(title: const Text('Step 4: గుణింతాల పదాలు'), backgroundColor: Colors.transparent, elevation: 0),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: provider.step4Words.length,
        itemBuilder: (context, index) {
          final item = provider.step4Words[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                RichImageCard(word: item.word, size: 70),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.word, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      Text(item.explanationText ?? '', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up_rounded, color: Colors.greenAccent, size: 30),
                  onPressed: () => provider.audioService.explainError(customMessage: item.word),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
