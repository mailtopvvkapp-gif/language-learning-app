import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_learning_app/core/language_provider.dart';
import 'package:flutter_learning_app/modules/home_dashboard_screen.dart';

class LanguageSelectScreen extends StatelessWidget {
  const LanguageSelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E122A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            children: [
              const Text(
                'Choose Language\nభాషను ఎంచుకోండి / भाषा चुनें',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 48),
              _buildCard(context, 'తెలుగు (Telugu)', 'అక్షరాలు, గుణింతాలు & పదాలు', AppLanguage.telugu, const Color(0xFF6C5CE7)),
              const SizedBox(height: 16),
              _buildCard(context, 'हिंदी (Hindi)', 'वर्णमाला, मात्राएँ & शब्द', AppLanguage.hindi, const Color(0xFF00B894)),
              const SizedBox(height: 16),
              _buildCard(context, 'English', 'Alphabet, Phonics & Words', AppLanguage.english, const Color(0xFF0984E3)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String sub, AppLanguage lang, Color col) {
    return InkWell(
      onTap: () async {
        await Provider.of<LanguageProvider>(context, listen: false).changeLanguage(lang);
        Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeDashboardScreen()));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: col.withOpacity(0.2),
          border: Border.all(color: col, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: col, child: const Icon(Icons.translate, color: Colors.white)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(sub, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
