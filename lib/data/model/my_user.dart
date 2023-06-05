class MyUser {
  static const String collectionName = "users";
  String id;
  String fullName;
  String email;

  MyUser(
      {required this.id,
      required this.fullName,
      required this.email});

  MyUser.fromFireStore(Map<String, dynamic> json)
      : this(
          id: json['id'],
          fullName: json['fullName'],
          email: json['email'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
    };
  }
}
