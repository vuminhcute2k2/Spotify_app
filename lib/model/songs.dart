// ignore_for_file: public_member_api_docs, sort_constructors_first
class Songs {
  // static const ID='id';
  // static const SONG='song';
  // static const IMAGE='image';
  // static const NAMESONG='nameSong';
  // static const AUTHOR='author';

  // String? id;
  // String? song;
  // String? image;
  // String? nameSong;
  // String? author;

  // Songs({
  //   required this.id,
  //   required this.song,
  //   required this.image,
  //   required this.nameSong,
  //   required this.author,
  // });

  // Songs.fromMap(Map<String, dynamic> data){
  //   id = data[ID];
  //   song =data[SONG];
  //   image = data[IMAGE];
  //   nameSong =data[NAMESONG];
  //   author =data[AUTHOR];
  // }
  final String id;
  final String song;
  final String nameSong;
  final String image;
  final String author;
  Songs({
    required this.id,
    required this.song,
    required this.nameSong,
    required this.image,
    required this.author,
  });
 
  Map<String,dynamic> toJson() => {
    "id" : id,
    "image" : image,
    "song" : song,
    "nameSong" : nameSong,
    "author" : author,
  };


}
