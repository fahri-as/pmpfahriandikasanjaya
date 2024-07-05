import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../core/app_export.dart';
import '../../widgets/custom_floating_text_field.dart'; // ignore_for_file: must_be_immutable

class DaftarSeminarScreen extends StatelessWidget {
  DaftarSeminarScreen({Key? key}) : super(key: key);

  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController roomIdController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  Future<void> _submitSeminarData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? internshipId = prefs.getString('internship_id');

    if (token == null || internshipId == null) {
      // Handle error
      return;
    }

    final response = await http.post(
      Uri.parse(
          'https://backend-pmp.unand.dev/api/my-internships/$internshipId/seminar'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        'title': titleController.text,
        'seminar_room_id': roomIdController.text,
        'link_seminar': linkController.text,
        'seminar_date': dateController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Handle success
      Navigator.pop(context); // Close current screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Seminar data saved successfully')),
      );

      // Optionally, refresh dashboard (if needed)
      // Navigator.pushReplacementNamed(context, '/dashboard'); // Example for navigating to dashboard
    } else {
      // Handle error
      print(
          'Failed to submit seminar data: ${response.statusCode} ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 12.v),
          child: Column(
            children: [
              _buildHeaderRow(context),
              SizedBox(height: 34.v),
              Text(
                "Daftar Seminar",
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 6.v),
              Divider(
                color: theme.colorScheme.primary,
              ),
              Divider(
                color: appTheme.green200,
              ),
              SizedBox(height: 19.v),
              _buildInputFields(context),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildHeaderRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 21.h,
        right: 15.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 10.v,
              bottom: 11.v,
            ),
            child: Text(
              "Welcome",
              style: theme.textTheme.titleSmall,
            ),
          ),
          Spacer(),
          FutureBuilder<String?>(
            future: _getUserName(), // Fetch username from SharedPreferences
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Placeholder while loading
              }
              if (snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: 13.v,
                    bottom: 12.v,
                  ),
                  child: Text(
                    snapshot.data!,
                    style: theme.textTheme.labelMedium,
                  ),
                );
              } else {
                return SizedBox(); // Handle error case or default behavior
              }
            },
          ),
          CustomImageView(
            imagePath: ImageConstant.imgAvatars3dAvatar21,
            height: 39.adaptSize,
            width: 39.adaptSize,
            margin: EdgeInsets.only(left: 8.h),
          )
        ],
      ),
    );
  }

  Future<String?> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name');
  }

  /// Section Widget
  Widget _buildInputFields(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 13.h,
        right: 19.h,
      ),
      decoration: AppDecoration.fillGreen.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder28,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(24.h, 13.v, 24.h, 12.v),
            decoration: AppDecoration.outlineOnPrimaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 3.v),
                Text(
                  "Select date",
                  style: CustomTextStyles.titleSmallGray800_1,
                ),
                SizedBox(height: 41.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Enter date",
                      style: theme.textTheme.headlineLarge,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgTrophy,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      margin: EdgeInsets.only(
                        top: 7.v,
                        bottom: 6.v,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              children: [
                CustomFloatingTextField(
                  controller: titleController,
                  labelText: "Title",
                  labelStyle: theme.textTheme.bodyLarge!,
                  hintText: "Enter Title",
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 10.v),
                CustomFloatingTextField(
                  controller: roomIdController,
                  labelText: "Seminar Room ID",
                  labelStyle: theme.textTheme.bodyLarge!,
                  hintText: "Enter Seminar Room ID",
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 10.v),
                CustomFloatingTextField(
                  controller: linkController,
                  labelText: "Link Seminar",
                  labelStyle: theme.textTheme.bodyLarge!,
                  hintText: "Enter Link Seminar",
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 10.v),
                CustomFloatingTextField(
                  controller: dateController,
                  labelText: "Date",
                  labelStyle: theme.textTheme.bodyLarge!,
                  hintText: "Enter Date",
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
          SizedBox(height: 35.v),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 24.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Cancel action
                    },
                    child: Text(
                      "Cancel",
                      style: CustomTextStyles.titleSmallGray800_1,
                    ),
                  ),
                  SizedBox(width: 24.h),
                  GestureDetector(
                    onTap: () {
                      _submitSeminarData(context); // Save action
                    },
                    child: Text(
                      "Save",
                      style: CustomTextStyles.titleSmallPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25.v),
        ],
      ),
    );
  }
}
