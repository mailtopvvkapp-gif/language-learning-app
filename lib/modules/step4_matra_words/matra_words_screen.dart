import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_learning_app/core/language_provider.dart';

class MatraWordsScreen extends StatelessWidget {
  const MatraWordsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF1E122A),
      appBar: AppBar(
        title: const Text('Step 4: గుణింతాల పదాలు'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: provider.step4Words.length,
        itemBuilder: (context, index) {
          final item = provider.step4Words[index];
          return Card(
            color: Colors.white.withOpacity(0.08),
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  item.imagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.image, color: Colors.white54, size: 40),
                ),
              ),
              title: Text(
                item.word,
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                item.explanationText ?? '',
                style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.volume_up, color: Colors.greenAccent, size: 28),
                onPressed: () {
                  provider.audioService.explainError(customMessage: item.word);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
