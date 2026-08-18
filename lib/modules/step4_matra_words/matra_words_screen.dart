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
      appBar: AppBar(
        title: const Text(
          'Step 4: గుణింతాల పదాలు (Advanced Words)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: provider.step4Words.isEmpty
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF6C5CE7)),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: provider.step4Words.length,
              itemBuilder: (context, index) {
                final item = provider.step4Words[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.12),
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // కోడ్ ద్వారానే వచ్చే ఆటోమేటిక్ HD బొమ్మ
                        RichImageCard(
                          word: item.word,
                          size: 70,
                        ),
                        const SizedBox(width: 16),

                        // పదం మరియు గుణింతం వివరణ
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.word,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item.explanationText ?? 'గుణింతంతో కూడిన పదం',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.75),
                                  fontSize: 13,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ఉచ్ఛారణ వినిపించే ఆడియో బటన్
                        IconButton(
                          icon: const Icon(
                            Icons.volume_up_rounded,
                            color: Colors.greenAccent,
                            size: 32,
                          ),
                          onPressed: () {
                            // పదం మరియు దాని వివరణను వాయిస్ ద్వారా చదువుతుంది
                            provider.audioService.explainError(
                              customMessage: item.word,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
