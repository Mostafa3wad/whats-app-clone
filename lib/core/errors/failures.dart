import 'package:equatable/equatable.dart';
import 'package:whats_app_clone/core/constants/messages/error_messages/general_error_messages.dart';

abstract class Failure extends Equatable {
  final List<dynamic> properties;

  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object?> get props => <Object?>[properties];
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({this.message = GeneralErrorMessages.serverError})
    : super(<String>[message]);

  @override
  String toString() => 'ServerFailure: $message';
}

class CacheFailure extends Failure {
  final String message;

  CacheFailure({this.message = GeneralErrorMessages.cacheError})
    : super(<String>[message]);

  @override
  String toString() => 'CacheFailure: $message';
}

class NetworkFailure extends Failure {
  final String message;

  NetworkFailure({this.message = GeneralErrorMessages.networkError})
    : super(<String>[message]);

  @override
  String toString() => 'NetworkFailure: $message';
}

class LocalDataFailure extends Failure {
  final String message;

  LocalDataFailure({this.message = GeneralErrorMessages.localDataError})
    : super(<String>[message]);

  @override
  String toString() => 'LocalDataFailure: $message';
}

class RemoteDataFailure extends Failure {
  final String message;

  RemoteDataFailure({this.message = GeneralErrorMessages.remoteDataError})
    : super(<String>[message]);

  @override
  String toString() => 'RemoteDataFailure: $message';
}

class ValidationFailure extends Failure {
  final String message;

  ValidationFailure({this.message = GeneralErrorMessages.validationError})
    : super(<String>[message]);

  @override
  String toString() => 'ValidationFailure: $message';
}

class NotFoundFailure extends Failure {
  final String message;

  NotFoundFailure({this.message = GeneralErrorMessages.notFoundError})
    : super(<String>[message]);

  @override
  String toString() => 'NotFoundFailure: $message';
}

class TimeoutFailure extends Failure {
  final String message;

  TimeoutFailure({this.message = GeneralErrorMessages.timeoutError})
    : super(<String>[message]);

  @override
  String toString() => 'TimeoutFailure: $message';
}

class UnauthorizedAccessFailure extends Failure {
  final String message;

  UnauthorizedAccessFailure({
    this.message = GeneralErrorMessages.unauthorizedAccessError,
  }) : super(<String>[message]);

  @override
  String toString() => 'UnauthorizedAccessFailure: $message';
}

class AuthenticationFailure extends Failure {
  final String message;

  AuthenticationFailure({
    this.message = GeneralErrorMessages.authenticationError,
  }) : super(<String>[message]);

  @override
  String toString() => 'AuthenticationFailure: $message';
}

class PermissionDeniedFailure extends Failure {
  final String message;

  PermissionDeniedFailure({
    this.message = GeneralErrorMessages.permissionDeniedError,
  }) : super(<String>[message]);

  @override
  String toString() => 'PermissionDeniedFailure: $message';
}

class DataCorruptionFailure extends Failure {
  final String message;

  DataCorruptionFailure({
    this.message = GeneralErrorMessages.dataCorruptedError,
  }) : super(<String>[message]);

  @override
  String toString() => 'DataCorruptionFailure: $message';
}

class ConflictFailure extends Failure {
  final String message;

  ConflictFailure({this.message = GeneralErrorMessages.conflictOccurredError})
    : super(<String>[message]);

  @override
  String toString() => 'ConflictFailure: $message';
}

class RateLimitExceededFailure extends Failure {
  final String message;

  RateLimitExceededFailure({
    this.message = GeneralErrorMessages.rateLimitExceededError,
  }) : super(<String>[message]);

  @override
  String toString() => 'RateLimitExceededFailure: $message';
}

class UnexpectedFailure extends Failure {
  final String message;

  UnexpectedFailure({this.message = GeneralErrorMessages.unexpectedError})
    : super(<String>[message]);

  @override
  String toString() => 'UnexpectedFailure: $message';
}
