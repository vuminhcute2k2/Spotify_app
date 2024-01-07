// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String email;
  final String about;
  final String uid;
  final String image;
  final String fullname;
  final String password;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.about,
    required this.uid,
    required this.image,
    required this.fullname,
    required this.password,
    required this.followers,
    required this.following,
  });

  Map<String,dynamic> toJson() => {
    "email" : email,
    "image" : image,
    "about" : about,
    "uid" : uid,
    "fullname" : fullname,
    "password" : password,
    "followers" : followers,
    "following" : following,
  };
}
