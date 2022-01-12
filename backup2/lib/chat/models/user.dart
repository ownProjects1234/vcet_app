// ignore_for_file: non_constant_identifier_names

class User {
  final String uid;

  User({required this.uid});

  Future<String> UserId() async {
    String userId = await uid;
    return userId;
  }
}
