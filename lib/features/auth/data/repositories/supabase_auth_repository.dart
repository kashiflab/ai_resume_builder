import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/base/base_repository.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';

/// Supabase implementation of the authentication repository
class SupabaseAuthRepository extends BaseRepository implements AuthRepository {
  final SupabaseClient _supabaseClient;

  SupabaseAuthRepository(this._supabaseClient);

  @override
  Future<Either<Failure, UserModel?>> getCurrentUser() async {
    return handleResponse(
      apiCall: () async {
        final user = _supabaseClient.auth.currentUser;
        if (user == null) return null;

        final response = await _supabaseClient
            .from('profiles')
            .select()
            .eq('id', user.id)
            .single();

        return UserModel.fromJson(response as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, UserModel>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return handleResponseWithError(
      apiCall: () async {
        final response = await _supabaseClient.auth.signInWithPassword(
          email: email,
          password: password,
        );

        final userResponse = await _supabaseClient
            .from('profiles')
            .select()
            .eq('id', response.user!.id)
            .single();

        return UserModel.fromJson(userResponse as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
  }) async {
    return handleResponseWithError(
      apiCall: () async {
        final response = await _supabaseClient.auth.signUp(
          email: email,
          password: password,
          data: {'full_name': fullName, 'email': email},
        );

        // await _supabaseClient.from('profiles').insert({
        //   'id': response.user!.id,
        //   'email': email,
        //   'full_name': fullName,
        //   'created_at': DateTime.now().toIso8601String(),
        //   'updated_at': DateTime.now().toIso8601String(),
        // });

        final userResponse = await _supabaseClient
            .from('profiles')
            .select()
            .eq('id', response.user!.id);

        return UserModel.fromJson(jsonDecode(jsonEncode(userResponse))[0]);
      },
    );
  }

  @override
  Future<Either<Failure, UserModel>> signInWithGoogle() async {
    return handleSocialSignIn(
      provider: 'google',
      apiCall: () async {
        final response = await _supabaseClient.auth.signInWithOAuth(
          OAuthProvider.google,
          redirectTo: 'io.supabase.flutterquickstart://login-callback/',
        );

        if (!response) {
          throw const AuthException('Google sign in failed');
        }

        final user = _supabaseClient.auth.currentUser;
        if (user == null) throw const AuthException('User not found');

        final userResponse = await _supabaseClient
            .from('profiles')
            .select()
            .eq('id', user.id)
            .single();

        return UserModel.fromJson(userResponse as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, UserModel>> signInWithLinkedIn() async {
    return handleSocialSignIn(
      provider: 'linkedin',
      apiCall: () async {
        // TODO: Implement LinkedIn sign in
        throw UnimplementedError();
      },
    );
  }

  @override
  Future<Either<Failure, UserModel>> signInWithApple() async {
    return handleSocialSignIn(
      provider: 'apple',
      apiCall: () async {
        final response = await _supabaseClient.auth.signInWithOAuth(
          OAuthProvider.apple,
          redirectTo: 'io.supabase.flutterquickstart://login-callback/',
        );

        if (!response) {
          throw const AuthException('Apple sign in failed');
        }

        final user = _supabaseClient.auth.currentUser;
        if (user == null) throw const AuthException('User not found');

        final userResponse = await _supabaseClient
            .from('profiles')
            .select()
            .eq('id', user.id)
            .single();

        return UserModel.fromJson(userResponse as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    return handleResponse(
      apiCall: () async {
        await _supabaseClient.auth.signOut();
      },
    );
  }

  @override
  Future<Either<Failure, UserModel>> updateProfile({
    required UserModel user,
  }) async {
    return handleProfileUpdate(
      apiCall: () async {
        final response = await _supabaseClient
            .from('profiles')
            .upsert(
              {
                ...user.toJson(),
                'updated_at': DateTime.now().toIso8601String(),
              },
            )
            .select()
            .single();

        return UserModel.fromJson(response as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, UserModel>> updateCareerGoals({
    required String userId,
    required Map<String, dynamic> careerGoals,
  }) async {
    return handleProfileUpdate(
      apiCall: () async {
        final response = await _supabaseClient
            .from('profiles')
            .update({
              'career_goals': careerGoals,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('id', userId)
            .select()
            .single();

        return UserModel.fromJson(response as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, UserModel>> updateJobPreferences({
    required String userId,
    required Map<String, dynamic> jobPreferences,
  }) async {
    return handleProfileUpdate(
      apiCall: () async {
        final response = await _supabaseClient
            .from('profiles')
            .update({
              'job_preferences': jobPreferences,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('id', userId)
            .select()
            .single();

        return UserModel.fromJson(response as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
  }) async {
    return handleResponseWithError(
      apiCall: () async {
        await _supabaseClient.auth.resetPasswordForEmail(email);
      },
    );
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return handleResponseWithError(
      apiCall: () async {
        await _supabaseClient.auth.updateUser(
          UserAttributes(password: newPassword),
        );
      },
    );
  }
}
