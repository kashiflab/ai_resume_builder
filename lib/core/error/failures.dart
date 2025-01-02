import 'package:equatable/equatable.dart';

/// Base failure class for the application
abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

/// Server failure
class ServerFailure extends Failure {
  const ServerFailure({
    required String message,
    String? code,
  }) : super(message: message, code: code);
}

/// Cache failure
class CacheFailure extends Failure {
  const CacheFailure({
    required String message,
    String? code,
  }) : super(message: message, code: code);
}

/// Network failure
class NetworkFailure extends Failure {
  const NetworkFailure({
    required String message,
    String? code,
  }) : super(message: message, code: code);
}

/// Validation failure
class ValidationFailure extends Failure {
  const ValidationFailure({
    required String message,
    String? code,
  }) : super(message: message, code: code);
}

/// Unknown failure
class UnknownFailure extends Failure {
  const UnknownFailure({
    String message = 'An unknown error occurred',
    String? code,
  }) : super(message: message, code: code);
}
