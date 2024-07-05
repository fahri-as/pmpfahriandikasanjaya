class UserProfile {
  final String nim;
  final String name;
  final int year;
  final String? departmentName; // Make departmentName nullable
  final String username;
  final String email;

  UserProfile({
    required this.nim,
    required this.name,
    required this.year,
    this.departmentName,
    required this.username,
    required this.email,
  });

  factory UserProfile.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException("Null JSON provided to UserProfile");
    }

    return UserProfile(
      nim: json['nim'] ?? "",
      name: json['name'] ?? "",
      year: json['year'] ?? 0,
      departmentName: json['department_name'],
      username: json['username'] ?? "",
      email: json['email'] ?? "",
    );
  }
}
