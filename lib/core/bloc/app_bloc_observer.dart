import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/core/logging/app_logger.dart';

class AppBlocObserver extends BlocObserver {
  final AppLogger _appLogger = AppLogger();

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    _appLogger.info('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    _appLogger.info('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    _appLogger.info('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    _appLogger.info('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    _appLogger.error('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    _appLogger.info('onClose -- ${bloc.runtimeType}');
  }
}
