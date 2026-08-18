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
  List<String> availableConsonants = [];
  Map<String, List<String>> fullGunintaluMap = {};
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
      case AppLanguage.telugu: return 'Step 1: అక్షరాలు (Alphabet)';
      case AppLanguage.hindi: return 'Step 1: वर्णमाला (Alphabet)';
      case AppLanguage.english: return 'Step 1: Alphabet (A to Z)';
    }
  }

  String get step2Title {
    switch (_currentLanguage) {
      case AppLanguage.telugu: return 'Step 2: అక్షరాల పదాలు (Root Words)';
      case AppLanguage.hindi: return 'Step 2: अक्षरों के शब्द (Root Words)';
      case AppLanguage.english: return 'Step 2: Words for Letters (A-Z)';
    }
  }

  String get step3Title {
    switch (_currentLanguage) {
      case AppLanguage.telugu: return 'Step 3: గుణింతాలు (క to క్ష)';
      case AppLanguage.hindi: return 'Step 3: बारहखड़ी (क to ज्ञ)';
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

  String get assessment1Title => '📝 Assessment 1 (Step 2 Quiz)';
  String get finalAssessmentTitle => '🏆 Final Assessment (Step 4 Quiz)';

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
        step1Letters = [
          'అ', 'ఆ', 'ఇ', 'ఈ', 'ఉ', 'ఊ', 'ఋ', 'ౠ', 'ఎ', 'ఏ', 'ఐ', 'ఒ', 'ఓ', 'ఔ', 'అం', 'అః',
          'క', 'ఖ', 'గ', 'ఘ', 'ఙ', 'చ', 'ఛ', 'జ', 'ఝ', 'ఞ', 'ట', 'ఠ', 'డ', 'ఢ', 'ణ',
          'త', 'థ', 'ద', 'ధ', 'న', 'ప', 'ఫ', 'బ', 'భ', 'మ', 'య', 'ర', 'ల', 'వ', 'శ', 'ష', 'స', 'హ', 'ళ', 'క్ష', 'ఱ'
        ];
        availableConsonants = [
          'క', 'ఖ', 'గ', 'ఘ', 'చ', 'ఛ', 'జ', 'ఝ', 'ట', 'ఠ', 'డ', 'ఢ', 'ణ',
          'త', 'థ', 'ద', 'ధ', 'న', 'ప', 'ఫ', 'బ', 'భ', 'మ', 'య', 'ర', 'ల', 'వ', 'శ', 'ష', 'స', 'హ', 'ళ', 'క్ష', 'ఱ'
        ];
        _buildTeluguGunintalu();
        break;

      case AppLanguage.hindi:
        langCode = 'hi-IN';
        jsonPath = 'assets/data/hindi_content.json';
        step1Letters = [
          'अ', 'आ', 'इ', 'ई', 'उ', 'ऊ', 'ऋ', 'ए', 'ऐ', 'ओ', 'औ', 'अं', 'अः',
          'क', 'ख', 'ग', 'घ', 'ङ', 'च', 'छ', 'ज', 'झ', 'ञ', 'ट', 'ठ', 'ड', 'ढ', 'ण',
          'त', 'थ', 'द', 'ध', 'न', 'प', 'फ', 'ब', 'भ', 'म', 'य', 'र', 'ल', 'व', 'श', 'ष', 'स', 'ह', 'क्ष', 'त्र', 'ज्ञ'
        ];
        availableConsonants = [
          'क', 'ख', 'ग', 'घ', 'च', 'छ', 'ज', 'झ', 'ट', 'ठ', 'ड', 'ढ', 'ण',
          'त', 'थ', 'द', 'ध', 'न', 'प', 'फ', 'ब', 'भ', 'म', 'य', 'र', 'ल', 'व', 'श', 'ष', 'स', 'ह', 'क्ष', 'त्र', 'ज्ञ'
        ];
        _buildHindiBarahkhadi();
        break;

      case AppLanguage.english:
        langCode = 'en-US';
        jsonPath = 'assets/data/english_content.json';
        step1Letters = [
          'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
          'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
        ];
        availableConsonants = ['BLENDS', 'DIGRAPHS'];
        fullGunintaluMap = {
          'BLENDS': ['BL', 'CL', 'FL', 'GL', 'PL', 'SL', 'BR', 'CR', 'DR', 'FR', 'GR', 'PR', 'TR', 'ST', 'SP', 'SK', 'SW'],
          'DIGRAPHS': ['SH', 'CH', 'TH', 'PH', 'WH', 'CK', 'QU', 'NG', 'NK']
        };
        break;
    }

    await audioService.initTTS(langCode);
    await _loadJsonData(jsonPath);

    isLoading = false;
    notifyListeners();
  }

  void _buildTeluguGunintalu() {
    fullGunintaluMap.clear();
    final suffixes = ['', 'ా', 'ి', 'ీ', 'ు', 'ూ', 'ృ', 'ె', 'ే', 'ై', 'ొ', 'ో', 'ౌ', 'ం', 'ః'];

    for (var c in availableConsonants) {
      if (c == 'క్ష') {
        fullGunintaluMap[c] = suffixes.map((s) => 'క్ష$s').toList();
      } else {
        fullGunintaluMap[c] = suffixes.map((s) => '$c$s').toList();
      }
    }
  }

  void _buildHindiBarahkhadi() {
    fullGunintaluMap.clear();
    final matras = ['', 'ा', 'ि', 'ी', 'ु', 'ू', 'ृ', 'े', 'ै', 'ो', 'ौ', 'ं', 'ः'];

    for (var c in availableConsonants) {
      if (c == 'र') {
        fullGunintaluMap[c] = ['र', 'रा', 'रि', 'री', 'रु', 'रू', 'रे', 'रै', 'रो', 'रौ', 'रं', 'रः'];
      } else {
        fullGunintaluMap[c] = matras.map((m) => '$c$m').toList();
      }
    }
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
