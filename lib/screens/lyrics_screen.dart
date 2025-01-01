import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/lyrics_service.dart';

class LyricsScreen extends StatelessWidget {
  final String songId;
  final String songTitle;

  LyricsScreen({required this.songId, required this.songTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(songTitle),
      ),
      body: Center(
        child: FutureBuilder<Map<String, String>>(
          future: LyricsService.getLyrics(songId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erreur de chargement');
            } else {
              final lyrics = snapshot.data?['lyrics'] ?? 'Paroles introuvables.';
              final youtubeUrl = snapshot.data?['youtubeUrl'] ?? '';
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: Colors.green.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          songTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          lyrics,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (await canLaunch(youtubeUrl)) {
                              await launch(youtubeUrl);
                            } else {
                              throw 'Could not launch $youtubeUrl';
                            }
                          },
                          icon: Icon(Icons.music_note),
                          label: Text('Écouter la chanson'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}