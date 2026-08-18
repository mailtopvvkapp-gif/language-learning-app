import 'package:flutter/material.dart';

class RichImageCard extends StatelessWidget {
  final String word;
  final double size;

  const RichImageCard({Key? key, required this.word, this.size = 140}) : super(key: key);

  Map<String, dynamic> _getGraphicData(String wordKey) {
    switch (wordKey.trim().toUpperCase()) {
      // Telugu / Hindi / English Root Words
      case 'అమ్మ': case 'MOTHER': return {'icon': '👩‍👧', 'bg': const Color(0xFFE84393)};
      case 'ఆవు': case 'COW': return {'icon': '🐄', 'bg': const Color(0xFF55EFC4)};
      case 'ఇల్లు': case 'HOUSE': case 'घर': return {'icon': '🏠', 'bg': const Color(0xFF0984E3)};
      case 'ఈగ': case 'FLY': return {'icon': '🪰', 'bg': const Color(0xFF636E72)};
      case 'ఉడుత': case 'SQUIRREL': return {'icon': '🐿️', 'bg': const Color(0xFFE17055)};
      case 'ఊయల': case 'SWING': return {'icon': '🪵', 'bg': const Color(0xFFFDCB6E)};
      case 'ఋషి': case 'SAGE': case 'ऋषि': return {'icon': '🧘‍♂️', 'bg': const Color(0xFFD63031)};
      case 'ఎలుక': case 'RAT': return {'icon': '🐀', 'bg': const Color(0xFF2D3436)};
      case 'ఏనుగు': case 'ELEPHANT': case 'हाथी': return {'icon': '🐘', 'bg': const Color(0xFF74B9FF)};
      case 'ఐదు': case 'FIVE': return {'icon': '🖐️', 'bg': const Color(0xFF6C5CE7)};
      case 'ఒంటె': case 'CAMEL': return {'icon': '🐪', 'bg': const Color(0xFFF39C12)};
      case 'ఓడ': case 'SHIP': case 'जहाज': return {'icon': '🚢', 'bg': const Color(0xFF2980B9)};
      case 'ఔషధం': case 'MEDICINE': return {'icon': '💊', 'bg': const Color(0xFFE74C3C)};
      case 'కలము': case 'PEN': case 'कलम': return {'icon': '✒️', 'bg': const Color(0xFF34495E)};
      case 'గంట': case 'BELL': return {'icon': '🔔', 'bg': const Color(0xFFF1C40F)};
      case 'చక్రం': case 'WHEEL': return {'icon': '🎡', 'bg': const Color(0xFF16A085)};
      case 'జడ': case 'BRAID': return {'icon': '💇‍♀️', 'bg': const Color(0xFF9B59B6)};
      case 'టమాటా': case 'TOMATO': case 'टमाटर': return {'icon': '🍅', 'bg': const Color(0xFFC0392B)};
      case 'డబ్బా': case 'BOX': return {'icon': '📦', 'bg': const Color(0xFFD35400)};
      case 'తల': case 'HEAD': return {'icon': '🧒', 'bg': const Color(0xFF1ABC9C)};
      case 'దండ': case 'GARLAND': return {'icon': '🏵️', 'bg': const Color(0xFFE67E22)};
      case 'ధనుస్సు': case 'BOW': case 'धनुष': return {'icon': '🏹', 'bg': const Color(0xFF8E44AD)};
      case 'నగ': case 'JEWEL': return {'icon': '💎', 'bg': const Color(0xFF3498DB)};
      case 'పలక': case 'SLATE': return {'icon': '📋', 'bg': const Color(0xFF2C3E50)};
      case 'ఫలం': case 'FRUITS': case 'फल': return {'icon': '🍎', 'bg': const Color(0xFFE74C3C)};
      case 'బంతి': case 'BALL': return {'icon': '⚽', 'bg': const Color(0xFF27AE60)};
      case 'హంస': case 'SWAN': return {'icon': '🦢', 'bg': const Color(0xFF7F8C8D)};

      // Gunintalu Words
      case 'కాకి': case 'CROW': case 'कौआ': return {'icon': '🦅', 'bg': const Color(0xFF2D3436)};
      case 'కిటికి': case 'WINDOW': return {'icon': '🪟', 'bg': const Color(0xFF0984E3)};
      case 'చేప': case 'FISH': case 'मछली': return {'icon': '🐟', 'bg': const Color(0xFF00CEC9)};
      case 'చిలుక': case 'PARROT': case 'तोता': return {'icon': '🦜', 'bg': const Color(0xFF00B894)};
      case 'చీమ': case 'ANT': return {'icon': '🐜', 'bg': const Color(0xFFE17055)};
      case 'టోపీ': case 'CAP': return {'icon': '🧢', 'bg': const Color(0xFF0984E3)};
      case 'దీపం': case 'LAMP': return {'icon': '🪔', 'bg': const Color(0xFFF39C12)};
      case 'పూలు': case 'FLOWERS': return {'icon': '🌸', 'bg': const Color(0xFFFD79A8)};
      case 'పిల్లి': case 'CAT': case 'बिल्ली': return {'icon': '🐱', 'bg': const Color(0xFFFDCB6E)};
      case 'పులి': case 'TIGER': return {'icon': '🐯', 'bg': const Color(0xFFD63031)};
      case 'మేక': case 'GOAT': return {'icon': '🐐', 'bg': const Color(0xFF6C5CE7)};
      case 'రాయి': case 'STONE': return {'icon': '🪨', 'bg': const Color(0xFF636E72)};

      // English Words (A to Z)
      case 'APPLE': return {'icon': '🍎', 'bg': const Color(0xFFFF7675)};
      case 'DOG': case 'कुत्ता': case 'కుక్క': return {'icon': '🐶', 'bg': const Color(0xFFE17055)};
      case 'EGG': return {'icon': '🥚', 'bg': const Color(0xFFFDCB6E)};
      case 'HEN': case 'मुर्गी': case 'కోడి': return {'icon': '🐔', 'bg': const Color(0xFFE84393)};
      case 'ICE': return {'icon': '🧊', 'bg': const Color(0xFF74B9FF)};
      case 'JUG': return {'icon': '🏺', 'bg': const Color(0xFF0984E3)};
      case 'KITE': case 'पतंग': return {'icon': '🪁', 'bg': const Color(0xFF6C5CE7)};
      case 'LION': case 'शेर': case 'సింహం': return {'icon': '🦁', 'bg': const Color(0xFFF39C12)};
      case 'MONKEY': return {'icon': '🐵', 'bg': const Color(0xFFD35400)};
      case 'NEST': return {'icon': '🪹', 'bg': const Color(0xFF16A085)};
      case 'OWL': case 'उल्लू': return {'icon': '🦉', 'bg': const Color(0xFF2C3E50)};
      case 'QUEEN': return {'icon': '👑', 'bg': const Color(0xFFF1C40F)};
      case 'RING': return {'icon': '💍', 'bg': const Color(0xFF3498DB)};
      case 'SUN': case 'सूरज': case 'సూర్యుడు': return {'icon': '☀️', 'bg': const Color(0xFFF39C12)};
      case 'TREE': case 'पेड़': case 'చెట్టు': return {'icon': '🌳', 'bg': const Color(0xFF27AE60)};
      case 'UMBRELLA': case 'छतरी': case 'గొడుగు': return {'icon': '☂️', 'bg': const Color(0xFF8E44AD)};
      case 'VAN': return {'icon': '🚐', 'bg': const Color(0xFF2980B9)};
      case 'WATCH': case 'घड़ी': case 'గడియారం': return {'icon': '⌚', 'bg': const Color(0xFF34495E)};
      case 'XYLOPHONE': return {'icon': '🎵', 'bg': const Color(0xFFE74C3C)};
      case 'YAK': return {'icon': '🐂', 'bg': const Color(0xFF7F8C8D)};
      case 'ZEBRA': return {'icon': '🦓', 'bg': const Color(0xFF2D3436)};
      case 'BOOK': case 'किताब': case 'పుస్తకం': return {'icon': '📖', 'bg': const Color(0xFF6C5CE7)};
      case 'CHAIR': return {'icon': '🪑', 'bg': const Color(0xFFD35400)};
      case 'CLOCK': return {'icon': '⏰', 'bg': const Color(0xFFE74C3C)};
      case 'FROG': return {'icon': '🐸', 'bg': const Color(0xFF2ECC71)};
      case 'STAR': return {'icon': '⭐', 'bg': const Color(0xFFF1C40F)};
      case 'TRAIN': return {'icon': '🚆', 'bg': const Color(0xFF34495E)};
      case 'DRUM': case 'डमरू': return {'icon': '🥁', 'bg': const Color(0xFFC0392B)};

      default: return {'icon': '🌟', 'bg': const Color(0xFF6C5CE7)};
    }
  }

  @override
  Widget build(BuildContext context) {
    final graphic = _getGraphicData(word);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [graphic['bg'], (graphic['bg'] as Color).withOpacity(0.75)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: (graphic['bg'] as Color).withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
      ),
      child: Center(
        child: Text(
          graphic['icon'],
          style: TextStyle(fontSize: size * 0.54),
        ),
      ),
    );
  }
}
