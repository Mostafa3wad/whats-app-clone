import 'package:whats_app_clone/core/service_locator/service_locator.dart';
import 'package:whats_app_clone/features/login/data/datasources/login_datasource.dart';
import 'package:whats_app_clone/features/login/data/repositories/login_repository_impl.dart';
import 'package:whats_app_clone/features/login/domain/repositories/login_repositort.dart';
import 'package:whats_app_clone/features/login/domain/usecases/send_otp_usecase.dart';
import 'package:whats_app_clone/features/login/domain/usecases/verify_otp_usecse.dart';
import 'package:whats_app_clone/features/login/presentation/cubit/login_cubit.dart';

void loginLocator() {
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(sl(), sl()),
  );

  sl.registerLazySingleton(() => LoginDataSource(sl()));

  sl.registerLazySingleton(() => SendOtpUseCase(sl()));

  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));

  sl.registerLazySingleton(() => LoginCubit(sl(), sl()));
}
