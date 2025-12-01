import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:whats_app_clone/core/logging/app_logger.dart';
import 'package:whats_app_clone/core/network/dio_client.dart';
import 'package:whats_app_clone/core/network/network_info.dart';
import 'package:whats_app_clone/features/login/login_locatoer.dart';

import '/core/helpers/database_helper.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

/// Initializes all the dependencies required by the application.
void initializeServiceLocator() {
  // Registering core dependencies
  sl.registerLazySingleton(DatabaseHelper.new);
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfo(sl()));

  sl.registerLazySingleton<Dio>(Dio.new);
  sl.registerLazySingleton<DioClient>(() => DioClient(sl()));

  sl.registerLazySingleton<AppLogger>(AppLogger.new);

  // =============== Login Dependencies ===============
  loginLocator();
}
