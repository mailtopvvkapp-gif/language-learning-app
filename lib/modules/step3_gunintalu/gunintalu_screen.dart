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
  String selectedConsonant = '';
  int currentVariationIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<LanguageProvider>(context, listen: false);
      if (provider.availableConsonants.isNotEmpty) {
        setState(() {
          selectedConsonant = provider.availableConsonants.first;
          currentVariationIndex = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final consonants = langProvider.availableConsonants;
    
    if (selectedConsonant.isEmpty && consonants.isNotEmpty) {
      selectedConsonant = consonants.first;
    }

    final activeGunintamList = langProvider.fullGunintaluMap[selectedConsonant] ?? [];
    final currentChar = activeGunintamList.isNotEmpty && currentVariationIndex < activeGunintamList.length
        ? activeGunintamList[currentVariationIndex]
        : selectedConsonant;

    return Scaffold(
      backgroundColor: const Color(0xFF1E122A),
      appBar: AppBar(
        title: Text(
          langProvider.step3Title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: consonants.isEmpty
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF6C5CE7)))
          : Column(
              children: [
                // 1. అక్షరాల ఎంపిక (క నుండి క్ష వరకు Consonants Bar)
                Container(
                  height: 55,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.08))),
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: consonants.length,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemBuilder: (context, index) {
                      final c = consonants[index];
                      final isSelected = c == selectedConsonant;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedConsonant = c;
                            currentVariationIndex = 0;
                          });
                          langProvider.audioService.explainError(customMessage: c);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF6C5CE7) : Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected ? Colors.white : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            c,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // 2. ఎంచుకున్న అక్షరం యొక్క గుణింతాల శ్రేణి (క, కా, కి, కీ, కు, కూ...)
                Container(
                  height: 62,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: activeGunintamList.length,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemBuilder: (context, index) {
                      final variation = activeGunintamList[index];
                      final isSelected = index == currentVariationIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() => currentVariationIndex = index);
                          langProvider.audioService.explainError(customMessage: variation);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF00B894) : Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected ? Colors.white : Colors.white24,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            variation,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // 3. వేలితో దిద్దడానికి Tracing Canvas
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: TracingCanvas(
                      key: ValueKey(currentChar),
                      charToTrace: currentChar,
                    ),
                  ),
                ),

                // 4. స్పష్టమైన వాయిస్ వినడానికి సౌండ్ బటన్
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C5CE7),
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 4,
                    ),
                    onPressed: () {
                      langProvider.audioService.explainError(customMessage: currentChar);
                    },
                    icon: const Icon(Icons.volume_up_rounded, size: 24),
                    label: Text(
                      'Listen: $currentChar',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

