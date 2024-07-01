import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
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

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      // Token not found, navigate to login screen
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.loginScreen, (route) => false);
    } else {
      futureInternships = fetchInternshipData(token);
      setState(() {});
    }
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    print('Token removed: ${prefs.getString('token')}'); // Debug print

    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.loginScreen, (route) => false);
    print('Navigated to Login Screen'); // Debug print
  }

  Future<List<Internship>> fetchInternshipData(String token) async {
    final response = await http.get(
      Uri.parse('https://backend-pmp.unand.dev/api/my-internships'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      print('Response data: ${response.body}'); // Debug print
      return internshipsFromJson(response.body);
    } else {
      print(
          'Failed to load internship data: ${response.statusCode} ${response.body}'); // Debug print
      throw Exception('Failed to load internship data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBarWelcome(context),
        body: futureInternships == null
            ? Center(child: CircularProgressIndicator())
            : Column(
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
          text: "Fahri Andika Sanjaya",
          margin: EdgeInsets.fromLTRB(15.h, 21.v, 8.h, 12.v),
        ),
        PopupMenuButton<String>(
          onSelected: (String result) {
            if (result == 'logout') {
              _logout(context);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'logout',
              child: Text('Logout'),
            ),
          ],
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
            "Kerja Praktek",
            style: CustomTextStyles.bodyMediumOnPrimary,
          ),
          SizedBox(height: 2.v),
          _buildStackTitleSemen(context, internship),
        ],
      ),
    );
  }

  Widget _buildStackTitleSemen(BuildContext context, Internship internship) {
    return SizedBox(
      height: 300.v,
      width: 294.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  internship.company,
                  style: theme.textTheme.bodyLarge,
                ),
                SizedBox(height: 4.v),
                Text(
                  internship.title,
                  style: theme.textTheme.bodyMedium,
                ),
                SizedBox(height: 33.v),
                SizedBox(
                  width: 61.h,
                  child: Text(
                    "Anggota :\nLorem\nIpsum\nDolor\nSit",
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      height: 1.43,
                    ),
                  ),
                ),
                SizedBox(height: 30.v),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomOutlinedButton(
                        width: 91.h,
                        text: "Report",
                      ),
                      CustomElevatedButton(
                        width: 85.h,
                        text: "Detail",
                        margin: EdgeInsets.only(left: 8.h),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.detailScreen,
                            arguments: internship.id,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
