import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../models/user_model.dart';

/// Authentication repository interface
abstract class AuthRepository {
  /// Get the current authenticated user
  Future<Either<Failure, UserModel?>> getCurrentUser();

  /// Sign in with email and password
  Future<Either<Failure, UserModel>> signInWithEmail({
    required String email,
    required String password,
  });

  /// Sign up with email and password
  Future<Either<Failure, UserModel>> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
  });

  /// Sign in with Google
  Future<Either<Failure, UserModel>> signInWithGoogle();

  /// Sign out the current user
  Future<Either<Failure, void>> signOut();

  /// Update user profile
  Future<Either<Failure, UserModel>> updateProfile({
    required UserModel user,
  });

  /// Reset password
  Future<Either<Failure, void>> resetPassword({
    required String email,
  });

  /// Sign in with LinkedIn
  Future<Either<Failure, UserModel>> signInWithLinkedIn();

  /// Sign in with Apple
  Future<Either<Failure, UserModel>> signInWithApple();
}
