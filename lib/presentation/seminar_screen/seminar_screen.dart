import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';

class SeminarScreen extends StatefulWidget {
  const SeminarScreen({Key? key}) : super(key: key);

  @override
  _SeminarScreenState createState() => _SeminarScreenState();
}

class _SeminarScreenState extends State<SeminarScreen> {
  String? selectedStudentId;
  List<Student> students = [];
  List<String> selectedStudentIds = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController seminarNotesController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      // Handle case where token is not available, maybe show a login screen
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://backend-pmp.unand.dev/api/students'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<dynamic> data = jsonData['data']; // Ambil array 'data' dari JSON
        List<Student> fetchedStudents =
            data.map((item) => Student.fromJson(item)).toList();

        setState(() {
          students = fetchedStudents;
        });

        // Logging: Data mahasiswa berhasil diambil
        print('Successfully fetched students: ${students.length} students');
      } else {
        throw Exception(
            'Failed to fetch students: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      // Logging: Error saat mengambil data mahasiswa
      print('Error fetching students: $e');
      // Optional: Print response body if available
      if (e is http.Response) {
        print('Response body: ${e.body}');
      }
    }
  }

  Future<void> _submitSeminarData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? internshipId = prefs.getString('internship_id');

    if (token == null || internshipId == null || selectedStudentIds.isEmpty) {
      // Handle error or validation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save seminar data')),
      );
      return;
    }

    try {
      final response = await http.put(
        Uri.parse(
            'https://backend-pmp.unand.dev/api/my-internships/$internshipId/seminar/$internshipId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'title': titleController.text,
          'date': dateController.text,
          'seminar_notes': seminarNotesController.text,
          'student_ids': selectedStudentIds,
        }),
      );

      if (response.statusCode == 200) {
        // Handle success
        Navigator.pop(context); // Close current screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Seminar data saved successfully')),
        );
        print('Seminar data saved successfully'); // Log success message
      } else if (response.statusCode == 500) {
        // Handle server error (500)
        print('Server error: Internal Server Error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: Internal Server Error')),
        );
      } else {
        // Handle other errors
        print(
            'Failed to submit seminar data: ${response.statusCode} ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save seminar data')),
        );
      }
    } catch (e) {
      // Handle exceptions
      print('Error submitting seminar data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting seminar data')),
      );
    }
  }

  void _addSelectedStudent() {
    if (selectedStudentId != null &&
        !selectedStudentIds.contains(selectedStudentId!)) {
      selectedStudentIds.add(selectedStudentId!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Student added for submission')),
      );
      setState(() {
        // Update selected student id list
        selectedStudentIds = List.from(selectedStudentIds);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderRow(context),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Seminar",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Divider(height: 12, thickness: 2),
                      SizedBox(height: 16),
                      _buildInputFields(context),
                      SizedBox(height: 16),
                      CustomElevatedButton(
                        height: 48,
                        text: "Seminar Telah Dilaksanakan",
                        onPressed: () {
                          _submitSeminarData(context);
                        },
                        buttonStyle: CustomButtonStyles.fillPrimaryTL10,
                        buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
                      ),
                      SizedBox(height: 16),
                      CustomElevatedButton(
                        height: 48,
                        text: "Back",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        buttonStyle: CustomButtonStyles.fillPrimaryTL10,
                        buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Text(
            "Welcome",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Spacer(),
          FutureBuilder<String?>(
            future: _getUserName(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                return Text(
                  snapshot.data!,
                  style: Theme.of(context).textTheme.bodyText2,
                );
              } else {
                return SizedBox();
              }
            },
          ),
          SizedBox(width: 8),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/avatar.png'),
            radius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildInputFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: titleController,
          decoration: InputDecoration(
            labelText: 'Title',
            hintText: 'Enter Title',
          ),
        ),
        SizedBox(height: 12),
        TextFormField(
          controller: dateController,
          decoration: InputDecoration(
            labelText: 'Date',
            hintText: 'Enter Date (YYYY-MM-DD)',
          ),
        ),
        SizedBox(height: 12),
        if (selectedStudentIds.isNotEmpty) ...[
          Text(
            'Selected Students:',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            itemCount: selectedStudentIds.length,
            itemBuilder: (context, index) {
              Student? selectedStudent = students.firstWhere(
                (student) => student.id == selectedStudentIds[index],
                orElse: () => Student(id: '', name: 'Unknown'),
              );
              return ListTile(
                title: Text(selectedStudent.name),
              );
            },
          ),
          SizedBox(height: 8),
        ],
        Text(
          'Select Student:',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedStudentId,
          onChanged: (newValue) {
            setState(() {
              selectedStudentId = newValue;
            });
          },
          items: students.map<DropdownMenuItem<String>>((Student student) {
            return DropdownMenuItem<String>(
              value: student.id,
              child: Text(student.name),
            );
          }).toList(),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintText: 'Select Student',
          ),
        ),
        SizedBox(height: 10.v),
        CustomElevatedButton(
            height: 53.v,
            text: "Add Selected Student",
            onPressed: () {
              _addSelectedStudent();
            }),
        SizedBox(height: 12),
        TextFormField(
          controller: seminarNotesController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Enter Seminar Notes (Optional)',
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Future<String?> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name');
  }
}

class Student {
  final String id;
  final String name;

  Student({
    required this.id,
    required this.name,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'], // Mengambil 'name' dari JSON response
    );
  }
}
