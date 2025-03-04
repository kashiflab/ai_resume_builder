import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:ai_resume_builder/core/base/base_repository.dart';
import 'package:ai_resume_builder/core/network/error/api_error.dart';
import 'package:ai_resume_builder/domain/entities/user_entity.dart';
import 'package:ai_resume_builder/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  final SupabaseClient _supabaseClient;

  AuthRepositoryImpl(this._supabaseClient);

  @override
  Future<Either<ApiError, UserEntity?>> getCurrentUser() async {
    return handleResponse(
      apiCall: () async {
        final user = _supabaseClient.auth.currentUser;
        if (user == null) return null;

        final response = await _supabaseClient
            .from('profiles')
            .select()
            .eq('id', user.id)
            .single();

        return UserEntity.fromJson(response as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<ApiError, UserEntity>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return handleResponse(
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

        return UserEntity.fromJson(userResponse as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<ApiError, UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
  }) async {
    return handleResponse(
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

        return UserEntity.fromJson(jsonDecode(jsonEncode(userResponse))[0]);
      },
    );
  }

  @override
  Future<Either<ApiError, UserEntity>> signInWithGoogle() async {
    return handleResponse(
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

        return UserEntity.fromJson(userResponse as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<ApiError, UserEntity>> signInWithLinkedIn() async {
    return handleResponse(
      apiCall: () async {
        // TODO: Implement LinkedIn sign in
        throw UnimplementedError();
      },
    );
  }

  @override
  Future<Either<ApiError, UserEntity>> signInWithApple() async {
    return handleResponse(
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

        return UserEntity.fromJson(userResponse as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Either<ApiError, void>> signOut() async {
    return handleResponse(
      apiCall: () async {
        await _supabaseClient.auth.signOut();
      },
    );
  }

  @override
  Future<Either<ApiError, UserEntity>> updateProfile({
    required UserEntity user,
  }) async {
    return handleResponse(
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

        return UserEntity.fromJson(response as Map<String, dynamic>);
      },
    );
  }

  // @override
  // Future<Either<ApiError, UserModel>> updateCareerGoals({
  //   required String userId,
  //   required Map<String, dynamic> careerGoals,
  // }) async {
  //   return handleResponse(
  //     apiCall: () async {
  //       final response = await _supabaseClient
  //           .from('profiles')
  //           .update({
  //             'career_goals': careerGoals,
  //             'updated_at': DateTime.now().toIso8601String(),
  //           })
  //           .eq('id', userId)
  //           .select()
  //           .single();

  //       return UserModel.fromJson(response as Map<String, dynamic>);
  //     },
  //   );
  // }

  @override
  // Future<Either<ApiError, UserModel>> updateJobPreferences({
  //   required String userId,
  //   required Map<String, dynamic> jobPreferences,
  // }) async {
  //   return handleResponse(
  //     apiCall: () async {
  //       final response = await _supabaseClient
  //           .from('profiles')
  //           .update({
  //             'job_preferences': jobPreferences,
  //             'updated_at': DateTime.now().toIso8601String(),
  //           })
  //           .eq('id', userId)
  //           .select()
  //           .single();

  //       return UserModel.fromJson(response as Map<String, dynamic>);
  //     },
  //   );
  // }

  @override
  Future<Either<ApiError, void>> resetPassword({
    required String email,
  }) async {
    return handleResponse(
      apiCall: () async {
        await _supabaseClient.auth.resetPasswordForEmail(email);
      },
    );
  }

  // @override
  // Future<Either<ApiError, void>> changePassword({
  //   required String currentPassword,
  //   required String newPassword,
  // }) async {
  //   return handleResponse(
  //     apiCall: () async {
  //       await _supabaseClient.auth.updateUser(
  //         UserAttributes(password: newPassword),
  //       );
  //     },
  //   );
  // }
}
