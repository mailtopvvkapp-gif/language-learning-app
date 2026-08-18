import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learning_app/core/audio_service.dart';
import 'package:flutter_learning_app/modules/assessments/quiz_controller.dart';

enum AppLanguage { telugu, hindi, english }

class LanguageProvider extends ChangeNotifier {
  final AudioFeedbackService audioService;
  AppLanguage _currentLanguage = AppLanguage.telugu;
  
  List<String> step1Letters = [];
  List<String> step3Gunintalu = [];
  List<QuizItem> step2Words = [];
  List<QuizItem> step4Words = [];
  bool isLoading = true;

  LanguageProvider({required this.audioService});

  AppLanguage get currentLanguage => _currentLanguage;

  // భాషను బట్టి డైనమిక్ టైటిల్స్
  String get languageName {
    switch (_currentLanguage) {
      case AppLanguage.telugu: return 'తెలుగు';
      case AppLanguage.hindi: return 'हिंदी';
      case AppLanguage.english: return 'English';
    }
  }

  String get step1Title {
    switch (_currentLanguage) {
      case AppLanguage.telugu: return 'Step 1: అక్షరాలు (Letters)';
      case AppLanguage.hindi: return 'Step 1: वर्णमाला (Letters)';
      case AppLanguage.english: return 'Step 1: Alphabet (Letters)';
    }
  }

  String get step2Title {
    switch (_currentLanguage) {
      case AppLanguage.telugu: return 'Step 2: సరళ పదాలు (Basic Words)';
      case AppLanguage.hindi: return 'Step 2: सरल शब्द (Basic Words)';
      case AppLanguage.english: return 'Step 2: Simple Words';
    }
  }

  String get assessment1Title {
    switch (_currentLanguage) {
      case AppLanguage.telugu: return '📝 అసెస్‌మెంట్ 1 (Step 2 క్విజ్)';
      case AppLanguage.hindi: return '📝 मूल्यांकन 1 (Step 2 क्विज़)';
      case AppLanguage.english: return '📝 Assessment 1 (Step 2 Quiz)';
    }
  }

  String get step3Title {
    switch (_currentLanguage) {
      case AppLanguage.telugu: return 'Step 3: గుణింతాలు (Gunintalu)';
      case AppLanguage.hindi: return 'Step 3: मात्राएँ (Matras)';
      case AppLanguage.english: return 'Step 3: Phonics & Blends';
    }
  }

  String get step4Title {
    switch (_currentLanguage) {
      case AppLanguage.telugu: return 'Step 4: గుణింతాల పదాలు (Advanced Words)';
      case AppLanguage.hindi: return 'Step 4: मात्रा वाले शब्द (Advanced Words)';
      case AppLanguage.english: return 'Step 4: Complex Words';
    }
  }

  String get finalAssessmentTitle {
    switch (_currentLanguage) {
      case AppLanguage.telugu: return '🏆 ఫైనల్ అసెస్‌మెంట్ (Final Quiz)';
      case AppLanguage.hindi: return '🏆 अंतिम मूल्यांकन (Final Quiz)';
      case AppLanguage.english: return '🏆 Final Assessment';
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
        step1Letters = ['అ', 'ఆ', 'ఇ', 'ఈ', 'ఉ', 'ఊ', 'ఋ', 'ఎ', 'ఏ', 'ఐ', 'ఒ', 'ఓ', 'ఔ', 'అం', 'క', 'ఖ', 'గ', 'ఘ', 'చ', 'ఛ', 'జ', 'ట', 'త', 'ద', 'న', 'ప', 'బ', 'మ', 'య', 'ర', 'ల', 'వ', 'స', 'హ'];
        step3Gunintalu = ['క', 'కా', 'కి', 'కీ', 'కు', 'కూ', 'కృ', 'కె', 'కే', 'కై', 'కొ', 'కో', 'కౌ', 'కం', 'కః'];
        break;
      case AppLanguage.hindi:
        langCode = 'hi-IN';
        jsonPath = 'assets/data/hindi_content.json';
        step1Letters = ['अ', 'आ', 'इ', 'ई', 'उ', 'ऊ', 'ऋ', 'ए', 'ऐ', 'ओ', 'औ', 'अं', 'क', 'ख', 'ग', 'घ', 'च', 'छ', 'ज', 'ट', 'त', 'द', 'न', 'प', 'ब', 'म', 'य', 'र', 'ल', 'व', 'स', 'ह'];
        step3Gunintalu = ['क', 'का', 'कि', 'की', 'कु', 'कू', 'कृ', 'के', 'कै', 'को', 'कौ', 'कं', 'कः'];
        break;
      case AppLanguage.english:
        langCode = 'en-US';
        jsonPath = 'assets/data/english_content.json';
        step1Letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
        step3Gunintalu = ['SH', 'CH', 'TH', 'PH', 'WH', 'BL', 'CL', 'FL', 'GL', 'PL', 'SL', 'BR', 'CR', 'DR', 'GR', 'PR', 'TR'];
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
      debugPrint("Error loading JSON content: $e");
    }
  }
}
