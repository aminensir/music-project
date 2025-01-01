import 'json_loader.dart';
import '../models/song.dart';

class SongService {
  static Future<List<Song>> getSongsByArtist(String artistId) async {
    final songs = await JsonLoader.loadJson('songs.json');
    return songs
        .where((song) => song['artistId'] == artistId)
        .map<Song>((json) => Song.fromJson(json))
        .toList();
  }
}
