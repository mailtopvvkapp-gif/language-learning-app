import 'package:flutter_tts/flutter_tts.dart';

class AudioFeedbackService {
  final FlutterTts _tts = FlutterTts();

  Future<void> initTTS(String languageCode) async {
    await _tts.setLanguage(languageCode);
    await _tts.setPitch(1.0);
    await _tts.setSpeechRate(0.38);
    await _tts.setVolume(1.0);
    await _tts.awaitSpeakCompletion(true);
  }

  Future<void> explainError({required String customMessage}) async {
    await _tts.stop();
    await _tts.speak(customMessage);
  }
}
