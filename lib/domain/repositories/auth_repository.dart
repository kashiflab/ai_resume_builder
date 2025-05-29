import 'package:ai_resume_builder/core/network/error/api_error.dart';
import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';

/// Authentication repository interface
abstract class AuthRepository {
  /// Get the current authenticated user
  Future<Either<ApiError, UserEntity?>> getCurrentUser();

  /// Sign in with email and password
  Future<Either<ApiError, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  });

  /// Sign up with email and password
  Future<Either<ApiError, UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
  });

  /// Sign in with Google
  Future<Either<ApiError, UserEntity>> signInWithGoogle();

  /// Sign out the current user
  Future<Either<ApiError, void>> signOut();

  /// Update user profile
  Future<Either<ApiError, UserEntity>> updateProfile({
    required UserEntity user,
  });

  /// Reset password
  Future<Either<ApiError, void>> resetPassword({
    required String email,
  });

  /// Sign in with LinkedIn
  Future<Either<ApiError, UserEntity>> signInWithLinkedIn();

  /// Sign in with Apple
  Future<Either<ApiError, UserEntity>> signInWithApple();
}
