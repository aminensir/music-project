import 'dart:convert';
import 'package:flutter/services.dart';

class LyricsService {
  static Future<Map<String, String>> getLyrics(String songId) async {
    final String response = await rootBundle.loadString('assets/lyrics.json');
    final List<dynamic> data = json.decode(response);
    final lyricsData = data.firstWhere((lyrics) => lyrics['id'] == songId, orElse: () => null);
    if (lyricsData != null) {
      return {
        'lyrics': lyricsData['lyrics'],
        'youtubeUrl': lyricsData['youtubeUrl'] ?? ''
      };
    } else {
      return {
        'lyrics': 'Paroles introuvables.',
        'youtubeUrl': ''
      };
    }
  }
}