class User {
  String fullName;
  String email;
  String password;

  User({required this.fullName, required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
    };
  }
}
