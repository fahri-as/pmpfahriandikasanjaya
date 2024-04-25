import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';

class SeminarScreen extends StatelessWidget {
  const SeminarScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 12.v),
          child: Column(
            children: [
              _buildHeaderRow(context),
              SizedBox(height: 34.v),
              Text(
                "Seminar",
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 6.v),
              Divider(
                color: theme.colorScheme.primary,
              ),
              Divider(
                color: appTheme.green200,
              ),
              SizedBox(height: 21.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 21.h),
                  child: Row(
                    children: [
                      CustomIconButton(
                        height: 22.adaptSize,
                        width: 22.adaptSize,
                        padding: EdgeInsets.all(1.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgRemoveCircle,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 15.h,
                          top: 3.v,
                        ),
                        child: Text(
                          "Seminar belum dilaksanakan",
                          style: CustomTextStyles.bodyMediumGray900_1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 22.v),
              CustomElevatedButton(
                height: 53.v,
                text: "Upload Bukti Seminar",
                margin: EdgeInsets.symmetric(horizontal: 15.h),
                buttonStyle: CustomButtonStyles.fillPrimaryTL10,
                buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
              ),
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
}
