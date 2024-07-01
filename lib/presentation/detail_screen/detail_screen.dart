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
import '../../models/detail_internship.dart'; // Import the DetailInternship model

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  Future<DetailInternship> fetchInternshipDetail(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('No token found');
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

  @override
  Widget build(BuildContext context) {
    final String internshipId =
        ModalRoute.of(context)!.settings.arguments as String;
    final theme = Theme.of(context); // Access the theme

    return SafeArea(
      child: Scaffold(
        appBar: _buildWelcomeAppBar(context),
        body: FutureBuilder<DetailInternship>(
          future: fetchInternshipDetail(internshipId),
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
                      CustomElevatedButton(
                        width: 80.h,
                        text: "Back",
                        margin: EdgeInsets.only(right: 5.h),
                        alignment: Alignment.centerRight,
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
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildWelcomeAppBar(BuildContext context) {
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
        AppbarTrailingImage(
          imagePath: ImageConstant.imgAvatars3dAvatar21,
          margin: EdgeInsets.only(
            left: 9.h,
            top: 8.v,
            right: 23.h,
          ),
        )
      ],
    );
  }
}
