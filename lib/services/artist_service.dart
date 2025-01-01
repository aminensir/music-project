import 'json_loader.dart';
import '../models/artist.dart';

class ArtistService {
  static Future<List<Artist>> getArtists() async {
    final artists = await JsonLoader.loadJson('artist.json');
    return artists.map<Artist>((json) => Artist.fromJson(json)).toList();
  }
}
