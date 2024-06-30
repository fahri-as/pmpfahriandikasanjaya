import 'dart:convert';

Internship internshipFromJson(String str) => Internship.fromJson(json.decode(str));

String internshipToJson(Internship data) => json.encode(data.toJson());

class Internship {
  final String id;
  final String title;
  final String company;
  final String startAt;
  final String endAt;
  final String status;
  final String seminarDate;
  final String grade;
  final String lecturer;

  Internship({
    required this.id,
    required this.title,
    required this.company,
    required this.startAt,
    required this.endAt,
    required this.status,
    required this.seminarDate,
    required this.grade,
    required this.lecturer,
  });

  factory Internship.fromJson(Map<String, dynamic> json) {
    return Internship(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      company: json['company'] ?? '',
      startAt: json['start_at'] ?? '',
      endAt: json['end_at'] ?? '',
      status: json['status'] ?? '',
      seminarDate: json['seminar_date'] ?? '',
      grade: json['grade'] ?? '',
      lecturer: json['lecturer'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'start_at': startAt,
      'end_at': endAt,
      'status': status,
      'seminar_date': seminarDate,
      'grade': grade,
      'lecturer': lecturer,
    };
  }
}
