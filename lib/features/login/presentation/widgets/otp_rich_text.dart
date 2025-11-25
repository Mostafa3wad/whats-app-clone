import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';
import 'package:whats_app_clone/config/themes/text_styles.dart';

class OtpRichText extends StatelessWidget {
  const OtpRichText({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text:
                'Waiting to automatically detect 6-digit code \nsent by SMS to',
            style: AppStyles.b1Blod.copyWith(
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
          ),
          TextSpan(
            text: ' $phoneNumber ',
            style: AppStyles.b1Blod.copyWith(
              color: Theme.of(context).colorScheme.inverseSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: ' Wrong \nnumber?',
            style: AppStyles.b1Blod.copyWith(
              fontSize: 13.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
