import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/config/themes/text_styles.dart';

import '../../../../config/themes/app_colors.dart';

class LoginAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LoginAppBar({
    super.key,
    required this.isValid,
    required this.onTap,
    required this.title,
  });
  final bool isValid;
  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: Container(),
      actions: <Padding>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: isValid ? onTap : null,
            child: Text(
              'Done',
              style: AppStyles.appBarStyle.copyWith(
                color: isValid ? AppColors.brandColor : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}
