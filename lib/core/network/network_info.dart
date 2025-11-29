import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:whats_app_clone/core/errors/exceptions.dart';
import 'package:whats_app_clone/core/errors/failures.dart';
import 'package:whats_app_clone/core/logging/app_logger.dart';

abstract class NetworkInfo {
  Future<Either<Failure, bool>> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  final AppLogger _appLogger = AppLogger();

  NetworkInfoImpl({required this.connectivity});

  @override
  Future<Either<Failure, bool>> get isConnected async {
    try {
      final List<ConnectivityResult> connectivityResult = await connectivity
          .checkConnectivity();
      final bool isConnected =
          connectivityResult != <ConnectivityResult>[ConnectivityResult.none];
      return Right<Failure, bool>(isConnected);
    } catch (e) {
      _appLogger.error('Failed to check network connectivity', e);
      throw NetworkException(
        message: 'Failed to check network connectivity: $e',
      );
    }
  }
}
