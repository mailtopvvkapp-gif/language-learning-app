void switchLanguage(String selectedLanguage) async {
  String langCode;
  String jsonPath;

  switch (selectedLanguage) {
    case 'Telugu':
      langCode = 'te-IN';
      jsonPath = 'assets/data/telugu_content.json';
      break;
    case 'Hindi':
      langCode = 'hi-IN';
      jsonPath = 'assets/data/hindi_content.json';
      break;
    case 'English':
    default:
      langCode = 'en-US';
      jsonPath = 'assets/data/english_content.json';
      break;
  }

  // Set Voice Language
  await audioService.initTTS(langCode);

  // Load Content for selected language
  await contentLoader.loadLanguageData(jsonPath);
}
