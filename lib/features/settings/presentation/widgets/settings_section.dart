import 'package:flutter/material.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';

class SettingsSection extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? margin;

  const SettingsSection({super.key, required this.children, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.grey2.withValues(alpha: 0.5),
            width: 0.5,
          ),
          bottom: BorderSide(
            color: AppColors.grey2.withValues(alpha: 0.5),
            width: 0.5,
          ),
        ),
      ),
      child: Column(children: children),
    );
  }
}
