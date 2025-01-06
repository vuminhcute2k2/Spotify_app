class Album {
  final String id;
  final String name;
  final String releasedate;
  final String artistName;
  final String image;
  final String zipUrl;

  Album({
    required this.id,
    required this.name,
    required this.releasedate,
    required this.artistName,
    required this.image,
    required this.zipUrl,
  });

  // Chuyển đổi từ JSON sang đối tượng Album
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      name: json['name'],
      releasedate: json['releasedate'],
      artistName: json['artist_name'],
      image: json['image'],
      zipUrl: json['zip'],
    );
  }
}

