import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_learning_app/core/audio_service.dart';
import 'package:flutter_learning_app/core/language_provider.dart';
import 'package:flutter_learning_app/modules/language_select/language_select_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(
            audioService: AudioFeedbackService(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Akshara',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const LanguageSelectScreen(),
      ),
    );
  }
}
