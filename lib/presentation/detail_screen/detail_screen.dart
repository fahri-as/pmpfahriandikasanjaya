import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildWelcomeAppBar(context),
        body: Container(
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
                  "Semen Padang",
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
                  "SI67822",
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
                  "21 Januari 2024 - 29 Februari 2024",
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
              )
            ],
          ),
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
