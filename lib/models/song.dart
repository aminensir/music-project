class Song {
  final String id;
  final String artistId;
  final String title;
  final String audio;
  final String lyricsId;

  Song({required this.id, required this.artistId, required this.title, required this.audio, required this.lyricsId});

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      artistId: json['artistId'],
      title: json['title'],
      audio: json['audio'],
      lyricsId: json['lyricsId'],
    );
  }
}