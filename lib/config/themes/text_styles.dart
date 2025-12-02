import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';

class AppStyles {
  static final TextStyle h3Blod = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle h2Blod = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle h1Blod = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle b1Blod = TextStyle(fontSize: 14.sp);

  static final TextStyle appBarStyle = const TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle settingsProfileName = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle settingsProfileSubtitle = TextStyle(
    fontSize: 14,
    color: AppColors.secondaryText,
  );

  static const TextStyle settingsItemTitle = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );

  static const TextStyle settingsItemSubtitle = TextStyle(
    fontSize: 13,
    color: AppColors.secondaryText,
  );

  // Chat text styles
  static const TextStyle chatNameStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle chatMessageStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryText,
  );

  static const TextStyle chatSubHeaderStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.normal,
    color: AppColors.brandColor,
  );

  static const TextStyle editModeBottomTextStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.normal,
  );
}
