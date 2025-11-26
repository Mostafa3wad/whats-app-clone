import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';
import 'package:whats_app_clone/core/constants/paths/app_assets.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.pageController,
    required this.currentIndex,
  });
  final int currentIndex;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: currentIndex,
      backgroundColor: AppColors.grey,
      onTap: pageController.jumpToPage,
      selectedItemColor: AppColors.brandColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(AppAssets.storySelected),
          icon: SvgPicture.asset(AppAssets.story),
          label: 'Status',
        ),
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(AppAssets.chatSelected),
          icon: SvgPicture.asset(AppAssets.chat),
          label: 'Chats',
        ),
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(AppAssets.settingSelected),
          icon: SvgPicture.asset(AppAssets.setting),
          label: 'Settings',
        ),
      ],
    );
  }
}
