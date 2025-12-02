import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';
import 'package:whats_app_clone/config/themes/text_styles.dart';
import 'package:whats_app_clone/core/constants/paths/app_assets.dart';
import 'package:whats_app_clone/core/constants/paths/route_names.dart';
import 'package:whats_app_clone/core/helpers/app_storage.dart';
import 'package:whats_app_clone/features/splash/presentation/widgets/policy_and_terms.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  Future<void> _completeOnboarding(BuildContext context) async {
    final AppStorage appStorage = AppStorage();
    await appStorage.init();

    // Save that user has seen onboarding (Hive)
    await appStorage.setOnboardingSeen();

    // Navigate to login page
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(AppAssets.welcomeImage),
            const SizedBox(height: 40),
            Text(
              'Welcome to WhatsaApp\nClone',
              textAlign: TextAlign.center,
              style: AppStyles.h3Blod,
            ),
            const PolicyAndTerms(),
            GestureDetector(
              onTap: () => _completeOnboarding(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Skip',
                    style: AppStyles.h2Blod.copyWith(color: AppColors.primary),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColors.primary,
                    size: 22.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
