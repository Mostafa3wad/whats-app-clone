import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';
import 'package:whats_app_clone/core/constants/paths/app_assets.dart';
import 'package:whats_app_clone/core/constants/paths/route_names.dart';
import 'package:whats_app_clone/core/helpers/app_storage.dart';
import 'package:whats_app_clone/features/splash/presentation/widgets/splash_loading_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AppStorage _appStorage = AppStorage();

  @override
  void initState() {
    super.initState();
    _setupSystemUI();
    _checkAppStatus();
  }

  Future<void> _setupSystemUI() async {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  /// Check app status and navigate to appropriate page
  Future<void> _checkAppStatus() async {
    // Initialize Hive
    await _appStorage.init();

    // Wait 2 seconds to show splash screen
    // await Future.delayed(const Duration(seconds: 1));

    if (!mounted) {
      return;
    }

    // 1. Check if token exists (FlutterSecureStorage)
    final bool hasToken = await _appStorage.hasToken();

    if (hasToken) {
      // User is logged in → Navigate to HomePage
      _navigateToHome();
      return;
    }

    // 2. Check if user has seen onboarding (Hive)
    final bool hasSeenOnboarding = _appStorage.hasSeenOnboarding();

    if (hasSeenOnboarding) {
      // User has seen onboarding → Navigate to LoginPage
      _navigateToLogin();
    } else {
      // User hasn't seen onboarding → Navigate to OnboardingPage
      _navigateToOnboarding();
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacementNamed(context, RouteNames.home);
  }

  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, RouteNames.login);
  }

  void _navigateToOnboarding() {
    Navigator.pushReplacementNamed(context, RouteNames.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(AppAssets.whatsLogo, width: 60.w, height: 60.h),
              const Spacer(),
              const SplashLoading(),
            ],
          ),
        ),
      ),
    );
  }
}
