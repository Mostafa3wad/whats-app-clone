import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:whats_app_clone/core/constants/keys/local_db_keys.dart';

/// Storage manager for app data
class AppStorage {
  final FlutterSecureStorage _secureStorage;
  Box? _settingsBox;

  AppStorage({FlutterSecureStorage? secureStorage})
    : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  /// Initialize Hive
  Future<void> init() async {
    if (_settingsBox == null || !_settingsBox!.isOpen) {
      await Hive.initFlutter();
      _settingsBox = await Hive.openBox(LocalDbKeys.onBoardingSeen);
    }
  }

  // ==================== Token Management (FlutterSecureStorage) ====================

  /// Save token to secure storage
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: LocalDbKeys.accessToken, value: token);
  }

  /// Get token from secure storage
  Future<String?> getToken() async {
    return await _secureStorage.read(key: LocalDbKeys.accessToken);
  }

  /// Delete token (Logout)
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: LocalDbKeys.accessToken);
  }

  /// Check if token exists
  Future<bool> hasToken() async {
    final String? token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // ==================== Onboarding Management (Hive) ====================

  /// Save onboarding status to Hive
  Future<void> setOnboardingSeen() async {
    await _settingsBox?.put(LocalDbKeys.hasSeenOnboardingKey, true);
  }

  /// Check if user has seen onboarding
  bool hasSeenOnboarding() {
    return _settingsBox?.get(
          LocalDbKeys.hasSeenOnboardingKey,
          defaultValue: false,
        ) ??
        false;
  }

  /// Reset onboarding (for testing)
  Future<void> resetOnboarding() async {
    await _settingsBox?.delete(LocalDbKeys.hasSeenOnboardingKey);
  }

  /// Clear all data (Complete logout)
  Future<void> clearAll() async {
    await deleteToken();
    await resetOnboarding();
  }
}
