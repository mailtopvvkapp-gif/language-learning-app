import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learning_app/core/audio_service.dart';
import 'package:flutter_learning_app/modules/assessments/quiz_controller.dart';

enum AppLanguage { telugu, hindi, english }

class LanguageProvider extends ChangeNotifier {
  final AudioFeedbackService audioService;
  AppLanguage _currentLanguage = AppLanguage.telugu;
  
  List<QuizItem> step2Words = [];
  List<QuizItem> step4Words = [];
  bool isLoading = true;

  LanguageProvider({required this.audioService});

  AppLanguage get currentLanguage => _currentLanguage;

  String get languageName {
    switch (_currentLanguage) {
      case AppLanguage.telugu:
        return 'తెలుగు';
      case AppLanguage.hindi:
        return 'हिंदी';
      case AppLanguage.english:
        return 'English';
    }
  }

  Future<void> changeLanguage(AppLanguage language) async {
    _currentLanguage = language;
    isLoading = true;
    notifyListeners();

    String langCode;
    String jsonPath;

    switch (language) {
      case AppLanguage.telugu:
        langCode = 'te-IN';
        jsonPath = 'assets/data/telugu_content.json';
        break;
      case AppLanguage.hindi:
        langCode = 'hi-IN';
        jsonPath = 'assets/data/hindi_content.json';
        break;
      case AppLanguage.english:
        langCode = 'en-US';
        jsonPath = 'assets/data/english_content.json';
        break;
    }

    await audioService.initTTS(langCode);
    await _loadJsonData(jsonPath);

    isLoading = false;
    notifyListeners();
  }

  Future<void> _loadJsonData(String path) async {
    try {
      final String response = await rootBundle.loadString(path);
      final data = json.decode(response);

      step2Words = (data['step2_words'] as List).map((item) {
        return QuizItem(
          id: item['id'],
          word: item['word'],
          imagePath: item['image_path'] ?? '',
          distractors: List<String>.from(item['distractors']),
          explanationText: item['explanation_audio_text'],
        );
      }).toList();

      step4Words = (data['step4_gunintalu_words'] as List).map((item) {
        return QuizItem(
          id: item['id'],
          word: item['word'],
          imagePath: item['image_path'] ?? '',
          distractors: List<String>.from(item['distractors']),
          explanationText: item['explanation_audio_text'],
        );
      }).toList();
    } catch (e) {
      debugPrint("Error loading content: $e");
    }
  }
}
