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
          _buildItem(context, 'Step 1: అక్షరాలు (Letters)', Icons.edit, Colors.blueAccent, () {}),
          _buildItem(context, 'Step 2: సరళ పదాలు (Basic Words)', Icons.menu_book, Colors.teal, () {}),
          _buildAssessment(context, '📝 Assessment 1 (Step 2 క్విజ్)', Colors.amber.shade800, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => QuizScreen(items: provider.step2Words, quizTitle: 'Assessment 1')));
          }),
          _buildItem(context, 'Step 3: గుణింతాలు (Gunintalu)', Icons.draw, Colors.deepPurpleAccent, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const GunintaluScreen()));
          }),
          _buildItem(context, 'Step 4: గుణింతాల పదాలు (Advanced Words)', Icons.auto_stories, Colors.indigoAccent, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const MatraWordsScreen()));
          }),
          _buildAssessment(context, '🏆 Final Assessment (Step 4 క్విజ్)', Colors.pinkAccent.shade400, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => QuizScreen(items: provider.step4Words, quizTitle: 'Final Assessment')));
          }),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String title, IconData icon, Color col, VoidCallback tap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      color: Colors.white.withOpacity(0.06),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: tap,
        leading: CircleAvatar(backgroundColor: col, child: Icon(icon, color: Colors.white)),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
      ),
    );
  }

  Widget _buildAssessment(BuildContext context, String title, Color col, VoidCallback tap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      color: col.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: col)),
      child: ListTile(
        onTap: tap,
        leading: CircleAvatar(backgroundColor: col, child: const Icon(Icons.quiz, color: Colors.white)),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.play_circle_fill, color: Colors.white, size: 28),
      ),
    );
  }
}
