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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Choose Language\nభాషను ఎంచుకోండి / भाषा चुनें',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 48),
              _buildLanguageCard(
                context: context,
                title: 'తెలుగు (Telugu)',
                subTitle: 'అక్షరాలు, గుణింతాలు & పదాలు',
                language: AppLanguage.telugu,
                color: const Color(0xFF6C5CE7),
              ),
              const SizedBox(height: 16),
              _buildLanguageCard(
                context: context,
                title: 'हिंदी (Hindi)',
                subTitle: 'वर्णमाला, मात्राएँ & शब्द',
                language: AppLanguage.hindi,
                color: const Color(0xFF00B894),
              ),
              const SizedBox(height: 16),
              _buildLanguageCard(
                context: context,
                title: 'English',
                subTitle: 'Alphabet, Phonics & Words',
                language: AppLanguage.english,
                color: const Color(0xFF0984E3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageCard({
    required BuildContext context,
    required String title,
    required String subTitle,
    required AppLanguage language,
    required Color color,
  }) {
    return InkWell(
      onTap: () async {
        final provider = Provider.of<LanguageProvider>(context, listen: false);
        await provider.changeLanguage(language);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HomeDashboardScreen()),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              radius: 24,
              child: const Icon(Icons.translate, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subTitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
          ],
        ),
      ),
    );
  }
}
