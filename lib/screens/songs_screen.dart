import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../services/song_service.dart';
import '../models/song.dart';
import 'lyrics_screen.dart';
import '../providers/color_provider.dart';

class SongsScreen extends StatefulWidget {
  final String artistId;

  SongsScreen({required this.artistId});

  @override
  _SongsScreenState createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final TextEditingController _searchController = TextEditingController();
  String _currentSongId = '';
  List<Song> _allSongs = [];
  List<Song> _filteredSongs = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterSongs);
    _loadSongs();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadSongs() async {
    try {
      final songs = await SongService.getSongsByArtist(widget.artistId);
      setState(() {
        _allSongs = songs;
        _filteredSongs = songs; // Initialement, toutes les chansons sont affichées
      });
    } catch (e) {
      // Gérer l'erreur
      print('Erreur lors du chargement des chansons: $e');
    }
  }

  void _filterSongs() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSongs = _allSongs.where((song) {
        return song.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chansons'),
        backgroundColor: colorProvider.selectedColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Rechercher une chanson',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.green[100],
              ),
            ),
          ),
          Expanded(
            child: _filteredSongs.isEmpty
                ? Center(child: Text('Aucune chanson trouvée'))
                : ListView.builder(
                    itemCount: _filteredSongs.length,
                    itemBuilder: (context, index) {
                      final song = _filteredSongs[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.green[50],
                        child: GestureDetector(
                          onTap: () {
                            if (_currentSongId == song.id) {
                              _audioPlayer.pause();
                              setState(() {
                                _currentSongId = '';
                              });
                            } else {
                              _audioPlayer.play('assets/audio/${song.audio}');
                              setState(() {
                                _currentSongId = song.id;
                              });
                            }
                          },
                          onDoubleTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LyricsScreen(
                                  songId: song.lyricsId,
                                  songTitle: song.title,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.favorite,
                              color: Colors.blue,
                            ),
                            title: Text(
                              song.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Icon(
                              _currentSongId == song.id ? Icons.pause : Icons.play_arrow,
                              color: colorProvider.selectedColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action pour ajouter une chanson
        },
        backgroundColor: colorProvider.selectedColor,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        color: colorProvider.selectedColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
    );
  }
}