import 'package:whats_app_clone/core/errors/failures.dart';

import '../constants/messages/error_messages/general_error_messages.dart';

class ServerException implements Exception {
  final String message;

  ServerException({this.message = GeneralErrorMessages.serverError});

  @override
  String toString() => 'ServerException: $message';
}

class CacheException implements Exception {
  final String message;

  CacheException({this.message = GeneralErrorMessages.cacheError});

  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;

  NetworkException({this.message = GeneralErrorMessages.networkError});

  @override
  String toString() => 'NetworkException: $message';
}

class LocalDataException implements Exception {
  final String message;

  LocalDataException({this.message = GeneralErrorMessages.localDataError});

  @override
  String toString() => 'LocalDataException: $message';
}

class RemoteDataException implements Exception {
  final String message;

  RemoteDataException({this.message = GeneralErrorMessages.remoteDataError});

  @override
  String toString() => 'RemoteDataException: $message';
}

class ValidationException implements Exception {
  final String message;

  ValidationException({this.message = GeneralErrorMessages.validationError});

  @override
  String toString() => 'ValidationException: $message';
}

class NotFoundException implements Exception {
  final String message;

  NotFoundException({this.message = GeneralErrorMessages.notFoundError});

  @override
  String toString() => 'NotFoundException: $message';
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException({this.message = GeneralErrorMessages.timeoutError});

  @override
  String toString() => 'TimeoutException: $message';
}

class UnauthorizedAccessException implements Exception {
  final String message;

  UnauthorizedAccessException({
    this.message = GeneralErrorMessages.unauthorizedAccessError,
  });

  @override
  String toString() => 'UnauthorizedAccessException: $message';
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({
    this.message = GeneralErrorMessages.authenticationError,
  });

  @override
  String toString() => 'AuthenticationException: $message';
}

class PermissionDeniedException implements Exception {
  final String message;

  PermissionDeniedException({
    this.message = GeneralErrorMessages.permissionDeniedError,
  });

  @override
  String toString() => 'PermissionDeniedException: $message';
}

class DataCorruptionException implements Exception {
  final String message;

  DataCorruptionException({
    this.message = GeneralErrorMessages.dataCorruptedError,
  });

  @override
  String toString() => 'DataCorruptionException: $message';
}

class ConflictException implements Exception {
  final String message;

  ConflictException({
    this.message = GeneralErrorMessages.conflictOccurredError,
  });

  @override
  String toString() => 'ConflictException: $message';
}

class RateLimitExceededException implements Exception {
  final String message;

  RateLimitExceededException({
    this.message = GeneralErrorMessages.rateLimitExceededError,
  });

  @override
  String toString() => 'RateLimitExceededException: $message';
}

Failure handleExceptions(Exception exception) {
  if (exception is ServerException) {
    return ServerFailure(message: exception.message);
  } else if (exception is CacheException) {
    return CacheFailure(message: exception.message);
  } else if (exception is NetworkException) {
    return NetworkFailure(message: exception.message);
  } else if (exception is LocalDataException) {
    return LocalDataFailure(message: exception.message);
  } else if (exception is RemoteDataException) {
    return RemoteDataFailure(message: exception.message);
  } else if (exception is ValidationException) {
    return ValidationFailure(message: exception.message);
  } else if (exception is NotFoundException) {
    return NotFoundFailure(message: exception.message);
  } else if (exception is AuthenticationException) {
    return AuthenticationFailure(message: exception.message);
  } else if (exception is PermissionDeniedException) {
    return PermissionDeniedFailure(message: exception.message);
  } else if (exception is DataCorruptionException) {
    return DataCorruptionFailure(message: exception.message);
  } else if (exception is TimeoutException) {
    return TimeoutFailure(message: exception.message);
  } else if (exception is UnauthorizedAccessException) {
    return UnauthorizedAccessFailure(message: exception.message);
  } else if (exception is ConflictException) {
    return ConflictFailure(message: exception.message);
  } else if (exception is RateLimitExceededException) {
    return RateLimitExceededFailure(message: exception.message);
  } else {
    return const UnexpectedFailure();
  }
}
