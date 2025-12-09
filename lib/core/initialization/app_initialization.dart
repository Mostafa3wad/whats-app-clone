import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/core/bloc/app_bloc_observer.dart';
import 'package:whats_app_clone/core/helpers/app_storage.dart';
import 'package:whats_app_clone/core/helpers/database_helper.dart';
import 'package:whats_app_clone/core/logging/app_logger.dart';
import 'package:whats_app_clone/core/service_locator/service_locator.dart';

class AppInitialization {
  final AppLogger appLogger;
  final DatabaseHelper databaseHelper;

  AppInitialization({required this.appLogger, required this.databaseHelper});

  Future<void> initialize() async {
    try {
      initializeServiceLocator();
      appLogger.initialize();
      Bloc.observer = AppBlocObserver();
      await databaseHelper.database;

      // Initialize AppStorage (Hive)
      await sl<AppStorage>().init();

      appLogger.info('Application initialized successfully.');
    } catch (error, stackTrace) {
      appLogger.error('Application initialization failed.', error, stackTrace);
      rethrow;
    }
    FlutterError.onError = (FlutterErrorDetails details) {
      if (kDebugMode) {
        FlutterError.presentError(details);
      }
      appLogger.error('FlutterError', details.exception, details.stack);
    };
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      appLogger.error('Uncaught (PlatformDispatcher)', error, stack);
      return true;
    };
  }
}
