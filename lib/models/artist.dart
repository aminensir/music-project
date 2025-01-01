class Artist {
  final String id;
  final String name;
  final String image;

  Artist({required this.id, required this.name, required this.image});

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}