import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
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
        appBar: _buildWelcomeAppBar(context),
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
                    width: 326.h,
                    margin: EdgeInsets.fromLTRB(17.h, 27.v, 17.h, 5.v),
                    padding: EdgeInsets.symmetric(
                      horizontal: 11.h,
                      vertical: 16.v,
                    ),
                    decoration: AppDecoration.fillGreen20001.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder12,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 13.v),
                        Padding(
                          padding: EdgeInsets.only(left: 5.h),
                          child: Text(
                            "Informasi Kegiatan",
                            style: CustomTextStyles.titleMediumOnPrimary,
                          ),
                        ),
                        SizedBox(height: 5.v),
                        CustomImageView(
                          imagePath: ImageConstant.imgImage1,
                          height: 122.adaptSize,
                          width: 122.adaptSize,
                          alignment: Alignment.center,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.h),
                          child: Text(
                            snapshot.data!.proposal.company.name,
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        SizedBox(height: 4.v),
                        Padding(
                          padding: EdgeInsets.only(left: 5.h),
                          child: Text(
                            "Kerja Praktek",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        SizedBox(height: 33.v),
                        Container(
                          width: 61.h,
                          margin: EdgeInsets.only(left: 5.h),
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
                        Divider(
                          indent: 5.h,
                        ),
                        //status kp
                        SizedBox(height: 35.v),
                        Padding(
                          padding: EdgeInsets.only(left: 5.h),
                          child: Text(
                            "Status Kerja Praktek",
                            style: CustomTextStyles.titleSmallGray800,
                          ),
                        ),
                        SizedBox(height: 6.v),
                        Padding(
                          padding: EdgeInsets.only(left: 5.h),
                          child: Text(
                            snapshot.data!.status,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        SizedBox(height: 35.v),
                        Divider(
                          indent: 5.h,
                        ),
                        //kode kegiatan
                        SizedBox(height: 35.v),
                        Padding(
                          padding: EdgeInsets.only(left: 5.h),
                          child: Text(
                            "Kode Kegiatan",
                            style: CustomTextStyles.titleSmallGray800,
                          ),
                        ),
                        SizedBox(height: 6.v),
                        Padding(
                          padding: EdgeInsets.only(left: 5.h),
                          child: Text(
                            snapshot.data!.id,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        SizedBox(height: 35.v),
                        Divider(
                          indent: 5.h,
                        ),
                        SizedBox(height: 35.v),
                        Padding(
                          padding: EdgeInsets.only(left: 5.h),
                          child: Text(
                            "Periode Kegiatan",
                            style: CustomTextStyles.titleSmallGray800,
                          ),
                        ),
                        SizedBox(height: 4.v),
                        Padding(
                          padding: EdgeInsets.only(left: 5.h),
                          child: Text(
                            "${snapshot.data!.startAt} - ${snapshot.data!.endAt}",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        SizedBox(height: 35.v),
                        Divider(
                          indent: 5.h,
                        ),
                        SizedBox(height: 31.v),

                        SizedBox(height: 22.v), // Spacing before the new button
                        CustomElevatedButton(
                          height: 53.v,
                          text: "Post Final",
                          margin: EdgeInsets.symmetric(horizontal: 15.h),
                          buttonStyle: CustomButtonStyles.fillPrimaryTL10,
                          buttonTextStyle:
                              CustomTextStyles.titleMediumWhiteA700,
                          onPressed: _postFinalInternship,
                        ),
                        SizedBox(height: 22.v), // Spacing before the new button
                        CustomElevatedButton(
                          height: 53.v,
                          text: "Back",
                          margin: EdgeInsets.symmetric(horizontal: 15.h),
                          buttonStyle: CustomButtonStyles.fillPrimaryTL10,
                          buttonTextStyle:
                              CustomTextStyles.titleMediumWhiteA700,
                          onPressed: () {
                            Navigator.pop(context);
                            // Add your logic for handling "Upload Bukti Seminar" button press
                            // For example, navigate to the upload screen
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

  PreferredSizeWidget _buildWelcomeAppBar(BuildContext context) {
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
        AppbarTrailingImage(
          imagePath: ImageConstant.imgAvatars3dAvatar21,
          margin: EdgeInsets.only(
            left: 9.h,
            top: 8.v,
            right: 23.h,
          ),
        ),
      ],
    );
  }
}
