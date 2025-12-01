import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({this.message});

  @override
  List<Object?> get props => <Object?>[message];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message});

  @override
  String toString() => 'ServerFailure: $message';
}

class CacheFailure extends Failure {
  const CacheFailure({super.message});

  @override
  String toString() => 'CacheFailure: $message';
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message});

  @override
  String toString() => 'NetworkFailure: $message';
}

class LocalDataFailure extends Failure {
  const LocalDataFailure({super.message});

  @override
  String toString() => 'LocalDataFailure: $message';
}

class RemoteDataFailure extends Failure {
  const RemoteDataFailure({super.message});

  @override
  String toString() => 'RemoteDataFailure: $message';
}

class ValidationFailure extends Failure {
  const ValidationFailure({super.message});

  @override
  String toString() => 'ValidationFailure: $message';
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message});

  @override
  String toString() => 'NotFoundFailure: $message';
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({super.message});

  @override
  String toString() => 'TimeoutFailure: $message';
}

class UnauthorizedAccessFailure extends Failure {
  const UnauthorizedAccessFailure({super.message});

  @override
  String toString() => 'UnauthorizedAccessFailure: $message';
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({super.message});

  @override
  String toString() => 'AuthenticationFailure: $message';
}

class PermissionDeniedFailure extends Failure {
  const PermissionDeniedFailure({super.message});

  @override
  String toString() => 'PermissionDeniedFailure: $message';
}

class DataCorruptionFailure extends Failure {
  const DataCorruptionFailure({super.message});

  @override
  String toString() => 'DataCorruptionFailure: $message';
}

class ConflictFailure extends Failure {
  const ConflictFailure({super.message});

  @override
  String toString() => 'ConflictFailure: $message';
}

class RateLimitExceededFailure extends Failure {
  const RateLimitExceededFailure({super.message});

  @override
  String toString() => 'RateLimitExceededFailure: $message';
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.message});
  @override
  String toString() => 'UnexpectedFailure: $message';
}
