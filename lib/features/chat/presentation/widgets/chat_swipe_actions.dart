import 'package:flutter/material.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';

class ChatSwipeActions extends StatelessWidget {
  final VoidCallback? onMoreTap;
  final VoidCallback? onArchiveTap;

  const ChatSwipeActions({super.key, this.onMoreTap, this.onArchiveTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _buildActionButton(
            icon: Icons.more_horiz,
            label: 'More',
            color: AppColors.secondaryText,
            onTap: onMoreTap ?? () {},
          ),
          const SizedBox(width: 12),
          _buildActionButton(
            icon: Icons.archive,
            label: 'Archive',
            color: AppColors.brandColor,
            onTap: onArchiveTap ?? () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
