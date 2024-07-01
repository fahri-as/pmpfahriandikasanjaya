class Login {
  final String token;
  final String type;
  final int expiresAt;

  Login({
    required this.token,
    required this.type,
    required this.expiresAt,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      token: json['data']['authorization']['token'],
      type: json['data']['authorization']['type'],
      expiresAt: json['data']['authorization']['expires_at'],
    );
  }
}
