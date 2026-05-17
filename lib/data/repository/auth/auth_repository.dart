import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/core/error/blog_exception.dart';
import 'package:tech_node/core/error/dio_exception_handler.dart';
import 'package:tech_node/data/model/auth/auth_model.dart';
import 'package:tech_node/core/network/dio_provider.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<AuthModel> login({required String email, required String password});
  Future<AuthModel> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  });
  Future<void> logout();
  Future<String> sendEmailVerification();
  Future<String> sendPasswordResetLink({required String email});
  Future<String> resetTheNewPassword({
    required String email,
    required String token,
    required String newPassword,
    required String newConPassword,
  });
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final dio = ref.watch(dioProvider);

  return AuthRepositoryImpl(dio);
}

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;

  AuthRepositoryImpl(this._dio);

  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        'login',
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200 && response.data['status'] == 'Success') {
        return AuthModel.fromJson(response.data['data']);
      }
      throw BlogException('Failed to login');
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }

  @override
  Future<AuthModel> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await _dio.post(
        'register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );
      if (response.statusCode == 201 && response.data['status'] == 'Success') {
        return AuthModel.fromJson(response.data['data']);
      }
      throw BlogException('Failed to register');
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      final response = await _dio.post('logout');
      if (response.statusCode == 200 && response.data['status'] == 'Success') {
        return;
      }
      throw BlogException('Failed to logout');
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return;
      }
      throw dioExceptionHandler(e);
    }
  }

  @override
  Future<String> sendEmailVerification() async {
    try {
      final response = await _dio.post('email/verification');
      if (response.statusCode == 200 && response.data['status'] == 'Success') {
        return response.data['message'];
      }
      throw BlogException('Failed to send email verification');
    } on DioException catch (e) {
      throw dioExceptionHandler(e);
    }
  }

  @override
  Future<String> sendPasswordResetLink({required String email}) async {
    try {
      final response = await _dio.post(
        'password/forget-password',
        data: {'email': email},
      );
      if (response.statusCode == 200 && response.data['status'] == 'Success') {
        return response.data['message'];
      }
      throw BlogException('Failed to send password reset link');
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw dioExceptionHandler(e);
    }
  }

  @override
  Future<String> resetTheNewPassword({
    required String email,
    required String token,
    required String newPassword,
    required String newConPassword,
  }) async {
    try {
      final response = await _dio.post(
        'password/reset-password',
        data: {
          'email': email,
          'token': token,
          'password': newPassword,
          'password_confirmation': newConPassword,
        },
      );
      if (response.statusCode == 200 && response.data['status'] == 'Success') {
        return response.data['message'];
      }
      throw BlogException('Failed to reset password');
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw dioExceptionHandler(e);
    }
  }
}
