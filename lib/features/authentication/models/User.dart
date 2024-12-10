class UserModel {
  const UserModel(String username, String email);

  factory UserModel.fromJson(Map<String, String> userJson){
    return UserModel(userJson["username"] ?? "", userJson["email"] ?? "");
  }
}