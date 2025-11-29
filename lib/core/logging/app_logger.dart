import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;

  final Logger _logger = Logger(
    filter: DevelopmentFilter(),
    printer: PrettyPrinter(
      dateTimeFormat: (DateTime time) =>
          '[${time.hour}:${time.minute}:${time.second}]',
    ),
  );

  bool isProduction = false;

  AppLogger._internal();

  void initialize({bool isProd = false}) {
    isProduction = isProd;
  }

  void debug(String message) {
    if (!isProduction) {
      _logger.d(message);
    }
  }

  void info(String message) {
    _logger.i(message);
  }

  void warning(String message) {
    _logger.w(message);
  }

  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (isProduction) {
      _logErrorToExternalService(error, stackTrace);
    }
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  void trace(String message) {
    if (!isProduction) {
      _logger.t(message);
    }
  }

  void fatal(String message) {
    _logger.f(message);
  }

  void _logErrorToExternalService(dynamic error, StackTrace? stackTrace) {
    if (kDebugMode) {
      print('Logging error to external service: $error');
    }
  }
}

class DevelopmentFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return !AppLogger().isProduction || event.level != Level.debug;
  }
}
