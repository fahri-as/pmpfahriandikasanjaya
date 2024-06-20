
import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    String token;
    String type;
    int expiresAt;

    Welcome({
        required this.token,
        required this.type,
        required this.expiresAt,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        token: json["token"],
        type: json["type"],
        expiresAt: json["expires_at"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "type": type,
        "expires_at": expiresAt,
    };
}
