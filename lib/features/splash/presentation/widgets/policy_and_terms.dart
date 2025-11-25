import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';
import 'package:whats_app_clone/config/themes/text_styles.dart';

class PolicyAndTerms extends StatelessWidget {
  const PolicyAndTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'Read our ',
              style: AppStyles.b1Blod.copyWith(
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            TextSpan(
              text: 'Privacy Policy ',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ),
            TextSpan(
              text: 'Tap “Agree and continue”to accept the ',
              style: AppStyles.b1Blod.copyWith(
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            TextSpan(
              text: 'Terms of Service.',
              style: AppStyles.b1Blod.copyWith(
                fontSize: 13.sp,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
