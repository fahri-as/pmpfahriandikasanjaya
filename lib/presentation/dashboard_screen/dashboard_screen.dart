import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../models/internship.dart'; // Import the Internship model

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<List<Internship>>? futureInternships;
  String? userName;

  @override
  void initState() {
    super.initState();
    _checkToken();
    _loadUserProfileName();
  }

  Future<void> _checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      // Token not found, navigate to login screen
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.loginScreen, (route) => false);
    } else {
      _fetchInternships(token);
    }
  }

  Future<void> _fetchInternships(String token) async {
    futureInternships = fetchInternshipData(token);
    setState(() {});
  }

  Future<List<Internship>> fetchInternshipData(String token) async {
    final response = await http.get(
      Uri.parse('https://backend-pmp.unand.dev/api/my-internships'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return internshipsFromJson(response.body);
    } else {
      throw Exception('Failed to load internship data');
    }
  }

  Future<void> _storeInternshipId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('internship_id', id);
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
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBarWelcome(context),
        body: futureInternships == null
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String token = prefs.getString('token')!;
                  _fetchInternships(token);
                },
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<List<Internship>>(
                        future: futureInternships,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return _buildDashboardContent(
                                    context, snapshot.data![index]);
                              },
                            );
                          } else {
                            return Center(child: Text('No data available'));
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () => _logout(context),
                        child: Text('Logout'),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBarWelcome(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitle(
        text: "Welcome",
        margin: EdgeInsets.only(left: 21.h),
      ),
      actions: [
        AppbarSubtitle(
          text: userName ?? "User Name",
          margin: EdgeInsets.fromLTRB(15.h, 21.v, 8.h, 12.v),
        ),
        InkWell(
          onTap: () async {
            Navigator.pushNamed(context, AppRoutes.profileScreen);
          },
          child: AppbarTrailingImage(
            imagePath: ImageConstant.imgAvatars3dAvatar21,
            margin: EdgeInsets.only(left: 9.h, top: 8.v, right: 23.h),
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardContent(BuildContext context, Internship internship) {
    return Container(
      width: 326.h,
      margin: EdgeInsets.fromLTRB(17.h, 28.v, 17.h, 5.v),
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 15.v),
      decoration: AppDecoration.fillGreen.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            internship.company,
            style: CustomTextStyles.titleMediumOnPrimary,
          ),
          SizedBox(height: 8.v),
          Text(
            internship.title,
            style: CustomTextStyles.bodyMediumOnPrimary,
          ),
          SizedBox(height: 8.v),
          Text(
            "Start Date: ${internship.startAt}",
            style: CustomTextStyles.bodyMediumOnPrimary,
          ),
          SizedBox(height: 8.v),
          Text(
            "End Date: ${internship.endAt}",
            style: CustomTextStyles.bodyMediumOnPrimary,
          ),
          SizedBox(height: 8.v),
          Text(
            "Status: ${internship.status}",
            style: CustomTextStyles.bodyMediumOnPrimary,
          ),
          SizedBox(height: 8.v),
          Text(
            "Seminar Date: ${internship.seminarDate ?? 'Not Scheduled'}",
            style: CustomTextStyles.bodyMediumOnPrimary,
          ),
          SizedBox(height: 8.v),
          Text(
            "Grade: ${internship.grade}",
            style: CustomTextStyles.bodyMediumOnPrimary,
          ),
          SizedBox(height: 8.v),
          Text(
            "Lecturer: ${internship.lecturer}",
            style: CustomTextStyles.bodyMediumOnPrimary,
          ),
          SizedBox(height: 8.v),
          _buildActionButtons(context, internship),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, Internship internship) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PopupMenuButton<String>(
            onSelected: (String result) async {
              switch (result) {
                case 'Seminar':
                  await _storeInternshipId(internship.id);
                  print('Seminar Date: ${internship.seminarDate}'); // Debug log
                  if (internship.seminarDate == null) {
                    Navigator.pushNamed(context, AppRoutes.daftarSeminarScreen);
                  } else {
                    Navigator.pushNamed(context, AppRoutes.seminarScreen);
                  }
                  break;
                case 'Kerja Praktek':
                  Navigator.pushNamed(context, AppRoutes.kerjaPraktekScreen);
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Seminar',
                child: Text('Seminar'),
              ),
              const PopupMenuItem<String>(
                value: 'Kerja Praktek',
                child: Text('Kerja Praktek'),
              ),
            ],
            child: CustomOutlinedButton(
              width: 91.h,
              text: "Seminar",
              onPressed: () async {
                await _storeInternshipId(internship.id);
                print('Seminar Date: ${internship.seminarDate}');
                if (internship.seminarDate == null ||
                    internship.seminarDate.isEmpty) {
                  Navigator.pushNamed(context, AppRoutes.daftarSeminarScreen);
                } else {
                  Navigator.pushNamed(context, AppRoutes.seminarScreen);
                }
              },
            ),
          ),
          CustomElevatedButton(
            width: 85.h,
            text: "Detail",
            margin: EdgeInsets.only(left: 8.h),
            onPressed: () async {
              await _storeInternshipId(internship.id);
              Navigator.pushNamed(
                context,
                AppRoutes.detailScreen,
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user_name');
    await prefs.remove('internship_id'); // Remove stored internship ID
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.loginScreen, (route) => false);
  }
}
