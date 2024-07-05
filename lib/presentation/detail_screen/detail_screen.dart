import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../theme/custom_button_style.dart';
import '../../theme/custom_text_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../models/detail_internship.dart'; // Import the DetailInternship model

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Future<DetailInternship>? futureDetailInternship;
  String? userName;

  @override
  void initState() {
    super.initState();
    _fetchInternshipDetail();
    _loadUserProfileName();
  }

  Future<void> _fetchInternshipDetail() async {
    futureDetailInternship = fetchInternshipDetail();
    setState(() {});
  }

  Future<DetailInternship> fetchInternshipDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? id = prefs.getString('internship_id');

    if (token == null || id == null) {
      throw Exception('No token or internship ID found');
    }

    final response = await http.get(
      Uri.parse('https://backend-pmp.unand.dev/api/my-internships/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return detailInternshipFromJson(response.body);
    } else {
      throw Exception('Failed to load internship detail');
    }
  }

  Future<void> _postFinalInternship() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? id = prefs.getString('internship_id');

    if (token == null || id == null) {
      throw Exception('No token or internship ID found');
    }

    final response = await http.post(
      Uri.parse('https://backend-pmp.unand.dev/api/my-internships/$id/final'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      // Check for specific error message in response
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('message') &&
          responseData['message'] == 'Can not complete your Internship') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to post final internship')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Final internship posted successfully')),
        );
      }
    } else {
      // Handle error response
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to post final internship')),
      );
    }
  }

  Future<void> _loadUserProfileName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedName = prefs.getString('user_name');
    setState(() {
      userName = storedName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Welcome"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(userName ?? "User Name"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/avatar.jpg'),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _fetchInternshipDetail,
          child: FutureBuilder<DetailInternship>(
            future: futureDetailInternship,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.green[200],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Informasi Kegiatan",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          snapshot.data!.proposal.company.name,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          snapshot.data!.reportTitle,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 24.0),
                        Text(
                          snapshot.data!.seminarNotes,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16.0, height: 1.5),
                        ),
                        SizedBox(height: 24.0),
                        Text(
                          "Status Kerja Praktek",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          snapshot.data!.status,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 24.0),
                        Text(
                          "Grade",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          snapshot.data!.grade,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 24.0),
                        Text(
                          "Tanggal Seminar",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${snapshot.data!.seminarDate}",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 24.0),
                        Text(
                          "Room Id Seminar",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          snapshot.data!.seminarRoomId ?? "",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 24.0),
                        Text(
                          "Link Seminar",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          snapshot.data!.linkSeminar ?? "",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 24.0),
                        Text(
                          "Kode Kegiatan",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          snapshot.data!.id,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 24.0),
                        Text(
                          "Periode Kegiatan",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${snapshot.data!.startAt} - ${snapshot.data!.endAt}",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 24.0),
                        CustomElevatedButton(
                          height: 48,
                          text: "Post Final",
                          onPressed: () {
                            _postFinalInternship();
                          },
                          buttonStyle: CustomButtonStyles.fillPrimaryTL10,
                          buttonTextStyle:
                              CustomTextStyles.titleMediumWhiteA700,
                        ),
                        SizedBox(height: 16.0),
                        CustomElevatedButton(
                          height: 48,
                          text: "Back",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ),
    );
  }
}
