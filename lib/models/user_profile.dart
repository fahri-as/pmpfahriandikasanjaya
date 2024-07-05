class UserProfile {
  String id;
  String? nik;
  String nim;
  String name;
  int year;
  String? gender;
  DateTime? birthday;
  String? birthplace;
  String? phone;
  String? address;
  String departmentId;
  String? photo;
  String? maritalStatus;
  int religion;
  int status;
  String counselorId;
  DateTime createdAt;
  DateTime updatedAt;
  String departmentName;
  String username;
  String email;

  UserProfile({
    required this.id,
    this.nik,
    required this.nim,
    required this.name,
    required this.year,
    this.gender,
    this.birthday,
    this.birthplace,
    this.phone,
    this.address,
    required this.departmentId,
    this.photo,
    this.maritalStatus,
    required this.religion,
    required this.status,
    required this.counselorId,
    required this.createdAt,
    required this.updatedAt,
    required this.departmentName,
    required this.username,
    required this.email,
  });

  factory UserProfile.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw Exception('Failed to parse user profile data');
    }

    return UserProfile(
      id: json['id'] ?? '',
      nik: json['nik'],
      nim: json['nim'] ?? '',
      name: json['name'] ?? '',
      year:
          json['year'] != null ? int.tryParse(json['year'].toString()) ?? 0 : 0,
      gender: json['gender'],
      birthday:
          json['birthday'] != null ? DateTime.parse(json['birthday']) : null,
      birthplace: json['birthplace'],
      phone: json['phone'],
      address: json['address'],
      departmentId: json['department_id'] ?? '',
      photo: json['photo'],
      maritalStatus: json['marital_status'],
      religion: json['religion'] != null
          ? int.tryParse(json['religion'].toString()) ?? 0
          : 0,
      status: json['status'] != null
          ? int.tryParse(json['status'].toString()) ?? 0
          : 0,
      counselorId: json['counselor_id'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      departmentName: json['department_name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
