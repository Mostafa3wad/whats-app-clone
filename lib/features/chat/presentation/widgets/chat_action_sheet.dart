import 'package:flutter/material.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';

class ChatActionSheet extends StatelessWidget {
  final VoidCallback? onMute;
  final VoidCallback? onContactInfo;
  final VoidCallback? onExportChat;
  final VoidCallback? onClearChat;
  final VoidCallback? onDeleteChat;
  final VoidCallback? onCancel;

  const ChatActionSheet({
    super.key,
    this.onMute,
    this.onContactInfo,
    this.onExportChat,
    this.onClearChat,
    this.onDeleteChat,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildActionItem(
            label: 'Mute',
            color: AppColors.brandColor,
            onTap: onMute ?? () {},
          ),
          const Divider(height: 1, color: AppColors.grey3),
          _buildActionItem(
            label: 'Contact Info',
            color: AppColors.brandColor,
            onTap: onContactInfo ?? () {},
          ),
          const Divider(height: 1, color: AppColors.grey3),
          _buildActionItem(
            label: 'Export Chat',
            color: AppColors.brandColor,
            onTap: onExportChat ?? () {},
          ),
          const Divider(height: 1, color: AppColors.grey3),
          _buildActionItem(
            label: 'Clear Chat',
            color: AppColors.brandColor,
            onTap: onClearChat ?? () {},
          ),
          const Divider(height: 1, color: AppColors.grey3),
          _buildActionItem(
            label: 'Delete Chat',
            color: AppColors.error,
            onTap: onDeleteChat ?? () {},
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: _buildActionItem(
              label: 'Cancel',
              color: AppColors.brandColor,
              onTap: onCancel ?? () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem({
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  static void show(
    BuildContext context, {
    VoidCallback? onMute,
    VoidCallback? onContactInfo,
    VoidCallback? onExportChat,
    VoidCallback? onClearChat,
    VoidCallback? onDeleteChat,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) => ChatActionSheet(
        onMute: onMute,
        onContactInfo: onContactInfo,
        onExportChat: onExportChat,
        onClearChat: onClearChat,
        onDeleteChat: onDeleteChat,
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }
}
