import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';

class KerjaPraktekScreen extends StatelessWidget {
  const KerjaPraktekScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 12.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 109.v),
                    child: Column(
                      children: [
                        _buildWelcomeSection(context),
                        SizedBox(height: 36.v),
                        Text(
                          "Kerja Praktek",
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: 4.v),
                        Divider(
                          color: theme.colorScheme.primary,
                        ),
                        Divider(
                          color: appTheme.green200,
                        ),
                        SizedBox(height: 11.v),
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
                                    left: 18.h,
                                    top: 4.v,
                                  ),
                                  child: Text(
                                    " Laporan akhir belum diunggah",
                                    style: CustomTextStyles.bodyMediumGray900,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 23.v),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 17.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 11.h,
                            vertical: 15.v,
                          ),
                          decoration: AppDecoration.fillGreen20001.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder12,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 14.v),
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
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 18.v),
                        CustomElevatedButton(
                          height: 53.v,
                          text: "Upload Laporan Akhir",
                          margin: EdgeInsets.only(
                            left: 18.h,
                            right: 12.h,
                          ),
                          buttonStyle: CustomButtonStyles.fillPrimaryTL10,
                          buttonTextStyle:
                              CustomTextStyles.titleMediumWhiteA700,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildWelcomeSection(BuildContext context) {
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
