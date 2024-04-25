import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_floating_text_field.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class DaftarSeminarScreen extends StatelessWidget {
  DaftarSeminarScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController dateController = TextEditingController();

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
              _buildInputDate(context),
              SizedBox(height: 5.v)
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
          Padding(
            padding: EdgeInsets.only(
              top: 13.v,
              bottom: 12.v,
            ),
            child: Text(
              "Fahri Andika Sanjaya",
              style: theme.textTheme.labelMedium,
            ),
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

  /// Section Widget
  Widget _buildInputDate(BuildContext context) {
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
            child: CustomFloatingTextField(
              controller: dateController,
              labelText: "Date",
              labelStyle: theme.textTheme.bodyLarge!,
              hintText: "Date",
              textInputAction: TextInputAction.done,
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
                  Text(
                    "Cancel",
                    style: CustomTextStyles.titleSmallPrimary,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 32.h),
                    child: Text(
                      "OK",
                      style: CustomTextStyles.titleSmallPrimary,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 23.v)
        ],
      ),
    );
  }
}
