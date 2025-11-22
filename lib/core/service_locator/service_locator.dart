import '/core/helpers/database_helper.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  ServiceLocator._();

  static final GetIt instance = GetIt.instance;
}

/// Initializes all the dependencies required by the application.
void initializeServiceLocator() {
  final GetIt sl = ServiceLocator.instance;

  // Registering core dependencies
  sl.registerLazySingleton(DatabaseHelper.new);

  // Registering feature-specific dependencies
  // _initializeAuthDependencies();
}

/// Registers the dependencies for the Auth feature.
// void _initializeAuthDependencies() {
//   AuthServiceLocator().setup();
// }
