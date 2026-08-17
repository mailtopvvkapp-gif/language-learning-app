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
  // ఉదాహరణకు 'క' గుణింతం లిస్ట్
  final List<String> teluguGunintalu = [
    'క', 'కా', 'కి', 'కీ', 'కు', 'కూ', 'కృ', 'కె', 'కే', 'కై', 'కొ', 'కో', 'కౌ', 'కం', 'కః'
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final currentChar = teluguGunintalu[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF1E122A),
      appBar: AppBar(
        title: const Text('Step 3: గుణింతాలు (Gunintalu)'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // పై భాగంలో గుణింతాల హారిజాంటల్ లిస్ట్
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: teluguGunintalu.length,
              itemBuilder: (context, index) {
                final isSelected = index == currentIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() => currentIndex = index);
                    langProvider.audioService.explainError(customMessage: teluguGunintalu[index]);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF6C5CE7) : Colors.white12,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? Colors.white : Colors.transparent,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        teluguGunintalu[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // మధ్యలో వేలితో దిద్దడానికి Tracing Canvas
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: TracingCanvas(
                  key: ValueKey(currentChar),
                  charToTrace: currentChar,
                ),
              ),
            ),
          ),

          // శబ్దం వినడానికి బటన్
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C5CE7),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                langProvider.audioService.explainError(customMessage: currentChar);
              },
              icon: const Icon(Icons.volume_up, size: 24),
              label: const Text('ఉచ్ఛారణ వినండి', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
