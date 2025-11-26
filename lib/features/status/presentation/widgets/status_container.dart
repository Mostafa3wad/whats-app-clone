import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';
import 'package:whats_app_clone/config/themes/text_styles.dart';
import 'package:whats_app_clone/core/constants/paths/app_assets.dart';

class StatusContainer extends StatelessWidget {
  const StatusContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      margin: EdgeInsets.symmetric(vertical: 35.w),
      height: 76.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: BoxBorder.symmetric(
          horizontal: BorderSide(color: AppColors.grey2, width: 0.9),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Row>[
          Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 29.w,
                    backgroundImage: const AssetImage(AppAssets.oval),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 9.r,
                      backgroundColor: AppColors.brandColor,
                      child: Icon(Icons.add, color: Colors.white, size: 18.r),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Text>[
                  Text('My Status', style: AppStyles.h1Blod),
                  Text(
                    'Add to my status',
                    style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              CircleAvatar(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.camera_alt,
                    color: AppColors.brandColor,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              CircleAvatar(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, color: AppColors.brandColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
