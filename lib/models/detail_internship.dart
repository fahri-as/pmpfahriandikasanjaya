import 'dart:convert';

DetailInternship detailInternshipFromJson(String str) =>
    DetailInternship.fromJson(json.decode(str));

String detailInternshipToJson(DetailInternship data) =>
    json.encode(data.toJson());

class DetailInternship {
  DetailInternship({
    required this.id,
    required this.internshipProposalId,
    required this.studentId,
    required this.advisorId,
    required this.status,
    required this.startAt,
    required this.endAt,
    required this.reportTitle,
    required this.seminarDate,
    required this.seminarRoomId,
    required this.linkSeminar,
    required this.seminarDeadline,
    required this.attendeesList,
    required this.internshipScore,
    required this.activityReport,
    required this.seminarNotes,
    required this.workReport,
    required this.certificate,
    required this.reportReceipt,
    required this.grade,
    required this.createdAt,
    required this.updatedAt,
    required this.proposal,
    required this.audiences,
  });

  String id;
  String internshipProposalId;
  String studentId;
  String advisorId;
  String status;
  DateTime startAt;
  DateTime endAt;
  String reportTitle;
  DateTime seminarDate;
  dynamic seminarRoomId;
  String linkSeminar;
  DateTime seminarDeadline;
  String attendeesList;
  String internshipScore;
  String activityReport;
  String seminarNotes;
  String workReport;
  String certificate;
  String reportReceipt;
  String grade;
  DateTime createdAt;
  DateTime updatedAt;
  Proposal proposal;
  List<dynamic> audiences;

  factory DetailInternship.fromJson(Map<String, dynamic> json) {
    return DetailInternship(
      id: json["id"]?.toString() ?? "",
      internshipProposalId: json["internship_proposal_id"]?.toString() ?? "",
      studentId: json["student_id"]?.toString() ?? "",
      advisorId: json["advisor_id"]?.toString() ?? "",
      status: json["status"]?.toString() ?? "",
      startAt: json["start_at"] != null
          ? DateTime.parse(json["start_at"])
          : DateTime.now(),
      endAt: json["end_at"] != null
          ? DateTime.parse(json["end_at"])
          : DateTime.now(),
      reportTitle: json["report_title"]?.toString() ?? "",
      seminarDate: json["seminar_date"] != null
          ? DateTime.parse(json["seminar_date"])
          : DateTime.now(),
      seminarRoomId: json["seminar_room_id"],
      linkSeminar: json["link_seminar"]?.toString() ?? "",
      seminarDeadline: json["seminar_deadline"] != null
          ? DateTime.parse(json["seminar_deadline"])
          : DateTime.now(),
      attendeesList: json["attendees_list"]?.toString() ?? "",
      internshipScore: json["internship_score"]?.toString() ?? "",
      activityReport: json["activity_report"]?.toString() ?? "",
      seminarNotes: json["seminar_notes"]?.toString() ?? "",
      workReport: json["work_report"]?.toString() ?? "",
      certificate: json["certificate"]?.toString() ?? "",
      reportReceipt: json["report_receipt"]?.toString() ?? "",
      grade: json["grade"]?.toString() ?? "",
      createdAt: json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : DateTime.now(),
      updatedAt: json["updated_at"] != null
          ? DateTime.parse(json["updated_at"])
          : DateTime.now(),
      proposal: json["proposal"] != null
          ? Proposal.fromJson(json["proposal"])
          : Proposal.empty(),
      audiences: json["audiences"] != null
          ? List<dynamic>.from(json["audiences"].map((x) => x))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "internship_proposal_id": internshipProposalId,
        "student_id": studentId,
        "advisor_id": advisorId,
        "status": status,
        "start_at": startAt.toIso8601String(),
        "end_at": endAt.toIso8601String(),
        "report_title": reportTitle,
        "seminar_date": seminarDate.toIso8601String(),
        "seminar_room_id": seminarRoomId,
        "link_seminar": linkSeminar,
        "seminar_deadline": seminarDeadline.toIso8601String(),
        "attendees_list": attendeesList,
        "internship_score": internshipScore,
        "activity_report": activityReport,
        "seminar_notes": seminarNotes,
        "work_report": workReport,
        "certificate": certificate,
        "report_receipt": reportReceipt,
        "grade": grade,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "proposal": proposal.toJson(),
        "audiences": List<dynamic>.from(audiences.map((x) => x)),
      };
}

class Proposal {
  Proposal({
    required this.id,
    required this.internshipStudentId,
    required this.internshipLecturerId,
    required this.type,
    required this.title,
    required this.companyId,
    required this.subject,
    required this.description,
    required this.status,
    required this.canceledAt,
    required this.createdAt,
    required this.updatedAt,
    required this.company,
  });

  String id;
  String internshipStudentId;
  String internshipLecturerId;
  String type;
  String title;
  String companyId;
  String subject;
  String description;
  String status;
  DateTime canceledAt;
  DateTime createdAt;
  DateTime updatedAt;
  Company company;

  factory Proposal.fromJson(Map<String, dynamic> json) {
    return Proposal(
      id: json["id"]?.toString() ?? "",
      internshipStudentId: json["internship_student_id"]?.toString() ?? "",
      internshipLecturerId: json["internship_lecturer_id"]?.toString() ?? "",
      type: json["type"]?.toString() ?? "",
      title: json["title"]?.toString() ?? "",
      companyId: json["company_id"]?.toString() ?? "",
      subject: json["subject"]?.toString() ?? "",
      description: json["description"]?.toString() ?? "",
      status: json["status"]?.toString() ?? "",
      canceledAt: json["canceled_at"] != null
          ? DateTime.parse(json["canceled_at"])
          : DateTime.now(),
      createdAt: json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : DateTime.now(),
      updatedAt: json["updated_at"] != null
          ? DateTime.parse(json["updated_at"])
          : DateTime.now(),
      company: json["company"] != null
          ? Company.fromJson(json["company"])
          : Company.empty(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "internship_student_id": internshipStudentId,
        "internship_lecturer_id": internshipLecturerId,
        "type": type,
        "title": title,
        "company_id": companyId,
        "subject": subject,
        "description": description,
        "status": status,
        "canceled_at": canceledAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "company": company.toJson(),
      };

  factory Proposal.empty() => Proposal(
        id: "",
        internshipStudentId: "",
        internshipLecturerId: "",
        type: "",
        title: "",
        companyId: "",
        subject: "",
        description: "",
        status: "",
        canceledAt: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        company: Company.empty(),
      );
}

class Company {
  Company({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String name;
  String address;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"]?.toString() ?? "",
        name: json["name"]?.toString() ?? "",
        address: json["address"]?.toString() ?? "",
        description: json["description"]?.toString() ?? "",
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : DateTime.now(),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  factory Company.empty() => Company(
        id: "",
        name: "",
        address: "",
        description: "",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}
