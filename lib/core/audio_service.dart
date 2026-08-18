import 'package:flutter_tts/flutter_tts.dart';

class AudioFeedbackService {
  final FlutterTts _tts = FlutterTts();

  Future<void> initTTS(String languageCode) async {
    await _tts.setLanguage(languageCode);
    
    // Pitch set to natural, warm tone
    await _tts.setPitch(1.0);
    
    // Slow speech rate for clear phonics and letter comprehension (0.35 to 0.40 is optimal for kids/learners)
    await _tts.setSpeechRate(0.38);
    
    // Volume level
    await _tts.setVolume(1.0);

    // iOS and Android playback configuration for clear speech
    await _tts.awaitSpeakCompletion(true);
    await _tts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.playback,
      [
        IosTextToSpeechAudioCategoryOptions.defaultToSpeaker,
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
      ],
    );
  }

  Future<void> explainError({required String customMessage}) async {
    await _tts.stop();
    // Speaks slowly and clearly
    await _tts.speak(customMessage);
  }
}
