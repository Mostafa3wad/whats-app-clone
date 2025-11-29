import 'package:flutter/material.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';
import 'package:whats_app_clone/config/themes/text_styles.dart';
import 'package:whats_app_clone/features/settings/presentation/widgets/settings_item.dart';
import 'package:whats_app_clone/features/settings/presentation/widgets/settings_profile_header.dart';
import 'package:whats_app_clone/features/settings/presentation/widgets/settings_section.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        title: const Text('Settings', style: AppStyles.settingsProfileName),
        backgroundColor: AppColors.grey,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          // Profile Header
          SettingsProfileHeader(
            name: 'Sabohiddin',
            subtitle: 'Digital goodies designer - Pixsellz',
            onTap: () {
              // TODO: Navigate to profile page
            },
          ),

          // Section 1: Starred Messages & WhatsApp Web
          SettingsSection(
            margin: const EdgeInsets.only(top: 20),
            children: <Widget>[
              SettingsItem(
                icon: Icons.star,
                iconColor: AppColors.iconYellow,
                title: 'Starred Messages',
                onTap: () {
                  // TODO: Navigate to starred messages
                },
              ),
              SettingsItem(
                icon: Icons.computer,
                iconColor: AppColors.iconGreen,
                title: 'WhatsApp Web/Desktop',
                showDivider: false,
                onTap: () {
                  // TODO: Navigate to WhatsApp Web
                },
              ),
            ],
          ),

          // Section 2: Main Settings
          SettingsSection(
            children: <Widget>[
              SettingsItem(
                icon: Icons.key,
                iconColor: AppColors.iconBlue,
                title: 'Account',
                onTap: () {
                  // TODO: Navigate to account settings
                },
              ),
              SettingsItem(
                icon: Icons.chat_bubble,
                iconColor: AppColors.iconGreen,
                title: 'Chats',
                onTap: () {
                  // TODO: Navigate to chats settings
                },
              ),
              SettingsItem(
                icon: Icons.notifications,
                iconColor: AppColors.iconRed,
                title: 'Notifications',
                onTap: () {
                  // TODO: Navigate to notifications settings
                },
              ),
              SettingsItem(
                icon: Icons.data_usage,
                iconColor: AppColors.iconGreen,
                title: 'Data and Storage Usage',
                showDivider: false,
                onTap: () {
                  // TODO: Navigate to data and storage settings
                },
              ),
            ],
          ),

          // Section 3: Help & Support
          SettingsSection(
            children: <Widget>[
              SettingsItem(
                icon: Icons.info,
                iconColor: AppColors.iconBlue,
                title: 'Help',
                onTap: () {
                  // TODO: Navigate to help
                },
              ),
              SettingsItem(
                icon: Icons.favorite,
                iconColor: AppColors.iconPink,
                title: 'Tell a Friend',
                showDivider: false,
                onTap: () {
                  // TODO: Share app
                },
              ),
            ],
          ),

          // Footer
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text(
                'WhatsApp clone from Mostafa',
                style: AppStyles.settingsFooter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
