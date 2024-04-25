import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBarWelcome(context),
        body: Container(
          width: 326.h,
          margin: EdgeInsets.fromLTRB(17.h, 28.v, 17.h, 5.v),
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 15.v,
          ),
          decoration: AppDecoration.fillGreen.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Semen Padang",
                style: CustomTextStyles.titleMediumOnPrimary,
              ),
              SizedBox(height: 8.v),
              Text(
                "Kerja Praktek",
                style: CustomTextStyles.bodyMediumOnPrimary,
              ),
              SizedBox(height: 2.v),
              _buildStackTitleSemenPadang(context)
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
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

  /// Section Widget
  Widget _buildStackTitleSemenPadang(BuildContext context) {
    return SizedBox(
      height: 356.v,
      width: 294.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage1,
            height: 122.adaptSize,
            width: 122.adaptSize,
            alignment: Alignment.topCenter,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Semen Padang",
                  style: theme.textTheme.bodyLarge,
                ),
                SizedBox(height: 4.v),
                Text(
                  "Kerja Praktek",
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
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}