import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  final String token;
  final String type;
  final int expiresAt;

  Welcome({
    required this.token,
    required this.type,
    required this.expiresAt,
  });

  factory Welcome.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException("Null JSON received");
    }
    return Welcome(
      token: json['token'] ?? "",
      type: json['type'] ?? "",
      expiresAt: json['expires_at'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "token": token,
      "type": type,
      "expires_at": expiresAt,
    };
  }
}
