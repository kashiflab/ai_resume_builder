import 'package:ai_resume_builder/core/network/error/api_error.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Base repository interface that all repositories should implement
abstract class BaseRepository {
  /// Handles API responses and returns Either<ApiError, T>
  Future<Either<ApiError, T>> handleResponse<T>({
    required Future<T> Function() apiCall,
  }) async {
    try {
      final response = await apiCall();
      return Right(response);
    } on DioException catch (e) {
      return Left(ApiError(
        code: e.response?.statusCode,
        message: e.response?.statusMessage,
      ));
    } on AuthException catch (e) {
      return Left(ApiError(supabaseCode: e.code, message: e.message));
    } on PostgrestException catch (e) {
      return Left(ApiError(supabaseCode: e.code, message: e.message));
    }
  }
}
