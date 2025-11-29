import 'package:flutter/material.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';
import 'package:whats_app_clone/config/themes/text_styles.dart';

class SettingsProfileHeader extends StatelessWidget {
  final String name;
  final String subtitle;
  final String avatarUrl;
  final VoidCallback? onTap;

  const SettingsProfileHeader({
    super.key,
    required this.name,
    required this.subtitle,
    this.avatarUrl = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(
            bottom: BorderSide(color: AppColors.grey2, width: 0.5),
          ),
        ),
        child: Row(
          children: <Widget>[
            // Avatar
            CircleAvatar(
              radius: 32,
              backgroundColor: AppColors.grey2,
              backgroundImage: avatarUrl.isNotEmpty
                  ? NetworkImage(avatarUrl)
                  : null,
              child: avatarUrl.isEmpty
                  ? Text(
                      name.isNotEmpty ? name[0].toUpperCase() : '?',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            // Name and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name, style: AppStyles.settingsProfileName),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppStyles.settingsProfileSubtitle),
                ],
              ),
            ),
            // Arrow
            const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
          ],
        ),
      ),
    );
  }
}
