class User {
  final String email;
  final String uid;
  final String fullname;
  final String password;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.uid,
    required this.fullname,
    required this.password,
    required this.followers,
    required this.following,
  });

  Map<String,dynamic> toJson() => {
    "email" : email,
    "uid" : uid,
    "fullname" : fullname,
    "password" : password,
    "followers" : followers,
    "following" : following,
  };
}