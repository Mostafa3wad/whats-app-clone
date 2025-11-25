import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/helpers/database_helper.dart';
import 'package:whats_app_clone/core/initialization/app_initialization.dart';
import 'package:whats_app_clone/core/initialization/system_configuration.dart';
import 'package:whats_app_clone/core/logging/app_logger.dart';
import 'package:whats_app_clone/whats_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  final AppLogger appLogger = AppLogger();
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final AppInitialization appInitializer = AppInitialization(
    appLogger: appLogger,
    databaseHelper: databaseHelper,
  );
  final SystemConfiguration systemConfiguration = SystemConfiguration();

  await appInitializer.initialize();
  systemConfiguration.configure();
  runApp(const WhatsApp());
}
