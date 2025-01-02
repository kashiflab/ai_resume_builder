import 'package:dartz/dartz.dart';
import '../error/failures.dart';
import '../utils/error_handler.dart';

/// Base repository interface that all repositories should implement
abstract class BaseRepository {
  /// Handles API responses and returns Either<Failure, T>
  Future<Either<Failure, T>> handleResponse<T>({
    required Future<T> Function() apiCall,
  }) async {
    try {
      final response = await apiCall();
      return Right(response);
    } catch (e) {
      return Left(UnknownFailure(
        message: ErrorHandler.getErrorMessage(e),
      ));
    }
  }

  /// Handles API responses with custom error handling
  Future<Either<Failure, T>> handleResponseWithError<T>({
    required Future<T> Function() apiCall,
    String Function(dynamic)? errorHandler,
  }) async {
    try {
      final response = await apiCall();
      return Right(response);
    } catch (e) {
      final errorMessage =
          errorHandler?.call(e) ?? ErrorHandler.getErrorMessage(e);
      return Left(UnknownFailure(message: errorMessage));
    }
  }

  /// Handles social sign-in responses
  Future<Either<Failure, T>> handleSocialSignIn<T>({
    required String provider,
    required Future<T> Function() apiCall,
  }) async {
    try {
      final response = await apiCall();
      return Right(response);
    } catch (e) {
      return Left(UnknownFailure(
        message: ErrorHandler.handleSocialSignInError(provider, e),
      ));
    }
  }

  /// Handles profile update responses
  Future<Either<Failure, T>> handleProfileUpdate<T>({
    required Future<T> Function() apiCall,
  }) async {
    try {
      final response = await apiCall();
      return Right(response);
    } catch (e) {
      return Left(UnknownFailure(
        message: ErrorHandler.handleProfileUpdateError(e),
      ));
    }
  }
}

/// Base remote data source interface
abstract class BaseRemoteDataSource {
  /// Base URL for API calls
  String get baseUrl;
}

/// Base local data source interface
abstract class BaseLocalDataSource {
  /// Key prefix for local storage
  String get keyPrefix;
}
