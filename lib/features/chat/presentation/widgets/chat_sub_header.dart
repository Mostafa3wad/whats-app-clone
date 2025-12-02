import 'package:flutter/material.dart';
import 'package:whats_app_clone/config/themes/text_styles.dart';

class ChatSubHeader extends StatelessWidget {
  const ChatSubHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
            onPressed: () {
              // Navigate to broadcast lists
            },
            child: const Text(
              'Broadcast Lists',
              style: AppStyles.chatSubHeaderStyle,
            ),
          ),
          TextButton(
            onPressed: () {
              // Navigate to new group
            },
            child: const Text('New Group', style: AppStyles.chatSubHeaderStyle),
          ),
        ],
      ),
    );
  }
}
