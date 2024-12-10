class Content {
  final String token;
  final String type;
  final int id;
  final String username;
  final List<String> roles;

  Content({
    required this.token,
    required this.type,
    required this.id,
    required this.username,
    required this.roles,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      token: json['token'],
      type: json['type'],
      id: json['id'],
      username: json['username'],
      roles: List<String>.from(json['roles']),
    );
  }
}