import 'package:flutter/material.dart';

class ChatConstants {
  // Colors
  static const Color chatBackgroundColor = Colors.white;
  static const Color chatTextColor = Colors.black;
  static const Color chatSecondaryTextColor = Color(0xFF8E8E93);
  static const Color chatDividerColor = Color(0xFFC6C6C8);
  static const Color chatSelectionColor = Color(0xFF007AFF);
  static const Color chatDeleteColor = Color(0xFFFF3B30);
  static const Color chatArchiveColor = Color(0xFF007AFF);
  static const Color chatMoreColor = Color(0xFF8E8E93);

  // Spacing
  static const double chatItemPadding = 16.0;
  static const double chatItemHeight = 72.0;
  static const double avatarSize = 56.0;
  static const double selectionCircleSize = 24.0;

  // Text Styles
  static const TextStyle chatNameStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: chatTextColor,
  );

  static const TextStyle chatMessageStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: chatSecondaryTextColor,
  );

  static const TextStyle chatTimestampStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: chatSecondaryTextColor,
  );

  static const TextStyle chatSubHeaderStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.normal,
    color: chatSelectionColor,
  );

  static const TextStyle editModeBottomTextStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.normal,
    color: chatTextColor,
  );
}


