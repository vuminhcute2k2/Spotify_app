class HistoryItem {
  final String songId;
  final String title;
  final String artist;
  final String imageUrl;
  final DateTime playedAt;

  HistoryItem({
    required this.songId,
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.playedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'songId': songId,
      'title': title,
      'artist': artist,
      'imageUrl': imageUrl,
      'playedAt': playedAt.toIso8601String(),
    };
  }

  static HistoryItem fromMap(Map<String, dynamic> map) {
    return HistoryItem(
      songId: map['songId'],
      title: map['title'],
      artist: map['artist'],
      imageUrl: map['imageUrl'],
      playedAt: DateTime.parse(map['playedAt']),
    );
  }
}
