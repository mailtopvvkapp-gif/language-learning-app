import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_learning_app/core/language_provider.dart';
import 'package:flutter_learning_app/modules/step3_gunintalu/gunintalu_screen.dart';
import 'package:flutter_learning_app/modules/step4_matra_words/matra_words_screen.dart';
import 'package:flutter_learning_app/modules/assessments/quiz_screen.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF1E122A),
      appBar: AppBar(
        title: Text('${provider.languageName} Dashboard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildStepCard(
            context,
            title: 'Step 1: అక్షరాలు (Letters)',
            subtitle: 'అచ్చులు, హల్లులు & Tracing',
            icon: Icons.edit,
            color: Colors.blueAccent,
            onTap: () {},
          ),
          _buildStepCard(
            context,
            title: 'Step 2: సరళ పదాలు (Basic Words)',
            subtitle: 'అక్షరాలతో కూడిన పదాలు',
            icon: Icons.menu_book,
            color: Colors.teal,
            onTap: () {},
          ),
          _buildAssessmentCard(
            context,
            title: '📝 Assessment 1 (Step 2 తర్వాత క్విజ్)',
            subtitle: 'చిత్రాలను చూసి సరైన పదాన్ని గుర్తించండి',
            color: Colors.amber.shade800,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuizScreen(
                    items: provider.step2Words,
                    quizTitle: 'Assessment 1: Basic Words',
                  ),
                ),
              );
            },
          ),
          _buildStepCard(
            context,
            title: 'Step 3: గుణింతాలు (Gunintalu)',
            subtitle: 'అక్షర మాత్రలు & రాయడం ప్రాక్టీస్',
            icon: Icons.draw,
            color: Colors.deepPurpleAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GunintaluScreen()),
              );
            },
          ),
          _buildStepCard(
            context,
            title: 'Step 4: గుణింతాల పదాలు (Advanced Words)',
            subtitle: 'గుణింతాలు మరియు వత్తులతో పదాలు',
            icon: Icons.auto_stories,
            color: Colors.indigoAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MatraWordsScreen()),
              );
            },
          ),
          _buildAssessmentCard(
            context,
            title: '🏆 Final Assessment (Step 4 తర్వాత క్విజ్)',
            subtitle: 'గుణింతాల పదాల అసెస్‌మెంట్ & వాయిస్ ఫీడ్‌బ్యాక్',
            color: Colors.pinkAccent.shade400,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuizScreen(
                    items: provider.step4Words,
                    quizTitle: 'Final Assessment: Gunintalu Words',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard(BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      color: Colors.white.withOpacity(0.06),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(backgroundColor: color, child: Icon(icon, color: Colors.white)),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
      ),
    );
  }

  Widget _buildAssessmentCard(BuildContext context, {
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      color: color.withOpacity(0.18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color, width: 1.5),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(backgroundColor: color, child: const Icon(Icons.quiz, color: Colors.white)),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        trailing: const Icon(Icons.play_circle_fill, color: Colors.white, size: 28),
      ),
    );
  }
}
