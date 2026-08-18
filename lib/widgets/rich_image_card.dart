import 'package:flutter/material.dart';

class RichImageCard extends StatelessWidget {
  final String word;
  final double size;

  const RichImageCard({
    Key? key,
    required this.word,
    this.size = 140,
  }) : super(key: key);

  Map<String, dynamic> _getGraphicData(String wordKey) {
    switch (wordKey.trim()) {
      case 'కలము':
      case 'कलम':
      case 'PEN':
        return {'icon': '✒️', 'color': const Color(0xFFFF7675), 'bg': const Color(0xFF2D3436)};
      case 'వల':
      case 'NET':
        return {'icon': '🕸️', 'color': const Color(0xFF74B9FF), 'bg': const Color(0xFF0984E3)};
      case 'పలక':
      case 'SLATE':
        return {'icon': '📋', 'color': const Color(0xFF55EFC4), 'bg': const Color(0xFF00B894)};
      case 'కమలము':
      case 'कमल':
      case 'LOTUS':
        return {'icon': '🪷', 'color': const Color(0xFFFD79A8), 'bg': const Color(0xFFE84393)};
      case 'కాకి':
      case 'कौआ':
      case 'CROW':
        return {'icon': '🦅', 'color': const Color(0xFF636E72), 'bg': const Color(0xFF2D3436)};
      case 'కితాబ్':
      case 'किताब':
      case 'పుస్తకం':
      case 'BOOK':
        return {'icon': '📖', 'color': const Color(0xFFA29BFE), 'bg': const Color(0xFF6C5CE7)};
      case 'చిలుక':
      case 'तोता':
      case 'PARROT':
        return {'icon': '🦜', 'color': const Color(0xFF00B894), 'bg': const Color(0xFF006266)};
      case 'కోడి':
      case 'मुर्गी':
      case 'HEN':
        return {'icon': '🐔', 'color': const Color(0xFFFF7675), 'bg': const Color(0xFFD63031)};
      default:
        return {'icon': '🌟', 'color': const Color(0xFFA29BFE), 'bg': const Color(0xFF6C5CE7)};
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
          colors: [graphic['bg'], (graphic['bg'] as Color).withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: (graphic['bg'] as Color).withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 2),
      ),
      child: Center(
        child: Text(
          graphic['icon'],
          style: TextStyle(fontSize: size * 0.52),
        ),
      ),
    );
  }
}
