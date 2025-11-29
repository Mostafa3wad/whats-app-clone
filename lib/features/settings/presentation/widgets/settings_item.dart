import 'package:flutter/material.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';
import 'package:whats_app_clone/config/themes/text_styles.dart';

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool showDivider;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: showDivider
              ? const Border(
                  bottom: BorderSide(color: AppColors.grey2, width: 0.5),
                )
              : null,
        ),
        child: Row(
          children: <Widget>[
            // Icon container
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, color: AppColors.white, size: 18),
            ),
            const SizedBox(width: 16),
            // Title and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: AppStyles.settingsItemTitle),
                  if (subtitle != null) ...<Widget>[
                    const SizedBox(height: 2),
                    Text(subtitle!, style: AppStyles.settingsItemSubtitle),
                  ],
                ],
              ),
            ),
            // Arrow
            const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}
