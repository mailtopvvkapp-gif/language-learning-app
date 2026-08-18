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

  String get languageName {
    switch (_currentLanguage) {
      case AppLanguage.telugu: return 'తెలుగు';
      case AppLanguage.hindi: return 'हिंदी';
      case AppLanguage.english: return 'English';
    }
  }

  String get step1Title {
    switch (_currentLanguage) {
      case AppLanguage.telugu: return 'Step 1: అక్షరాలు (Full Alphabet)';
      case AppLanguage.hindi: return 'Step 1: संपूर्ण वर्णमाला (Alphabet)';
      case AppLanguage.english: return 'Step 1: Letters (A to Z)';
    }
  }

  String get step2Title {
    switch (_currentLanguage) {
      case AppLanguage.telugu: return 'Step 2: అక్షరాల పదాలు (A for Apple Style)';
      case AppLanguage.hindi: return 'Step 2: अक्षरों के शब्द (Words for Letters)';
      case AppLanguage.english: return 'Step 2: Words for Letters (A-Z)';
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
      case AppLanguage.telugu: return 'Step 3: గుణింతాలు (Full Gunintalu)';
      case AppLanguage.hindi: return 'Step 3: मात्राएँ (Matras)';
      case AppLanguage.english: return 'Step 3: Phonics & Blends';
    }
  }

  String get step4Title {
    switch (_currentLanguage) {
      case AppLanguage.telugu: return 'Step 4: గుణింతాల పదాలు (Advanced Words)';
      case AppLanguage.hindi: return 'Step 4: मात्रा वाले शब्द (Advanced Words)';
      case AppLanguage.english: return 'Step 4: Complex Blend Words';
    }
  }

  String get finalAssessmentTitle {
    switch (_currentLanguage) {
      case AppLanguage.telugu: return '🏆 ఫైనల్ అసెస్‌మెంట్ (Final Assessment)';
      case AppLanguage.hindi: return '🏆 अंतिम मूल्यांकन (Final Assessment)';
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
        // పూర్తి తెలుగు వర్ణమాల (అచ్చులు + హల్లులు)
        step1Letters = [
          'అ', 'ఆ', 'ఇ', 'ఈ', 'ఉ', 'ఊ', 'ఋ', 'ౠ', 'ఎ', 'ఏ', 'ఐ', 'ఒ', 'ఓ', 'ఔ', 'అం', 'అః',
          'క', 'ఖ', 'గ', 'ఘ', 'ఙ', 'చ', 'ఛ', 'జ', 'ఝ', 'ఞ', 'ట', 'ఠ', 'డ', 'ఢ', 'ణ',
          'త', 'థ', 'ద', 'ధ', 'న', 'ప', 'ఫ', 'బ', 'భ', 'మ', 'య', 'ర', 'ల', 'వ', 'శ', 'ష', 'స', 'హ', 'ళ', 'క్ష', 'ఱ'
        ];
        // గుణింతాల గుర్తులు & ఉదాహరణలు
        step3Gunintalu = [
          'క', 'కా', 'కి', 'కీ', 'కు', 'కూ', 'కృ', 'కౄ', 'కె', 'కే', 'కై', 'కొ', 'కో', 'కౌ', 'కం', 'కః',
          'గ', 'గా', 'గి', 'గీ', 'గు', 'గూ', 'గృ', 'గె', 'గే', 'గై', 'గొ', 'గో', 'గౌ', 'గం', 'గః',
          'చ', 'చా', 'చి', 'చీ', 'చు', 'చూ', 'చె', 'చే', 'చై', 'చొ', 'చో', 'చౌ', 'చం', 'చః',
          'త', 'తా', 'తి', 'తీ', 'తు', 'తూ', 'తె', 'తే', 'తై', 'తొ', 'తో', 'తౌ', 'తం', 'తః',
          'ప', 'పా', 'పి', 'పీ', 'పు', 'పూ', 'పె', 'పే', 'పై', 'పొ', 'పో', 'పౌ', 'పం', 'పః'
        ];
        break;

      case AppLanguage.hindi:
        langCode = 'hi-IN';
        jsonPath = 'assets/data/hindi_content.json';
        // पूर्ण हिंदी वर्णमाला (स्वर + व्यंजन)
        step1Letters = [
          'अ', 'आ', 'इ', 'ई', 'उ', 'ऊ', 'ऋ', 'ए', 'ऐ', 'ओ', 'औ', 'अं', 'अः',
          'क', 'ख', 'ग', 'घ', 'ङ', 'च', 'छ', 'ज', 'झ', 'ञ', 'ट', 'ठ', 'ड', 'ढ', 'ण',
          'त', 'थ', 'द', 'ध', 'न', 'प', 'फ', 'ब', 'भ', 'म', 'य', 'र', 'ल', 'व', 'श', 'ष', 'स', 'ह', 'क्ष', 'त्र', 'ज्ञ'
        ];
        step3Gunintalu = [
          'क', 'का', 'कि', 'की', 'कु', 'कू', 'कृ', 'के', 'कै', 'को', 'कौ', 'कं', 'कः',
          'ग', 'गा', 'गि', 'गी', 'गु', 'गू', 'गे', 'गै', 'गो', 'गौ', 'गं', 'गः',
          'त', 'ता', 'ति', 'ती', 'तु', 'तू', 'ते', 'तै', 'तो', 'तौ', 'तं', 'तः',
          'प', 'पा', 'पि', 'पी', 'पु', 'पू', 'पे', 'पै', 'पो', 'पौ', 'पं', 'पः'
        ];
        break;

      case AppLanguage.english:
        langCode = 'en-US';
        jsonPath = 'assets/data/english_content.json';
        // Full English Alphabet (A to Z)
        step1Letters = [
          'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
          'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
        ];
        step3Gunintalu = [
          'SH', 'CH', 'TH', 'PH', 'WH', 'BL', 'CL', 'FL', 'GL', 'PL', 'SL',
          'BR', 'CR', 'DR', 'FR', 'GR', 'PR', 'TR', 'ST', 'SP', 'SK', 'SW'
        ];
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
          letter: item['letter'] ?? '',
          imagePath: item['image_path'] ?? '',
          distractors: List<String>.from(item['distractors']),
          explanationText: item['explanation_audio_text'],
        );
      }).toList();

      step4Words = (data['step4_gunintalu_words'] as List).map((item) {
        return QuizItem(
          id: item['id'],
          word: item['word'],
          letter: item['letter'] ?? '',
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
