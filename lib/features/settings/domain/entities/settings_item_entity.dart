import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum SettingsItemType { profile, navigation, action }

class SettingsItemEntity extends Equatable {
  final String id;
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final SettingsItemType type;
  final VoidCallback? onTap;

  const SettingsItemEntity({
    required this.id,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.type = SettingsItemType.navigation,
    this.onTap,
  });

  @override
  List<Object?> get props => <Object?>[
    id,
    title,
    subtitle,
    icon,
    iconColor,
    type,
  ];
}
