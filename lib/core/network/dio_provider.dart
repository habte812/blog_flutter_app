// ignore_for_file: deprecated_member_use, empty_catches

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_node/data/model/auth/auth_model.dart';

final dioProvider = Provider<Dio>((ref) {
  const storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.0.184:8080/api/',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final sessionJson = await storage.read(key: 'user_session');
        if (sessionJson != null) {
          try {
            final auth = AuthModel.fromJson(jsonDecode(sessionJson));
            options.headers['Authorization'] =
                '${auth.tokenType} ${auth.accessToken}';
          } catch (e) {}
        }
        return handler.next(options);
      },
      // onError: (DioException error, handler) {
      //   final theCode = error.response?.statusCode;
      //   if (theCode == 401) {
      //     ref.read(authProvider.notifier).logout();
      //   }

      //   return handler.next(error);
      // },
    ),
  );
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  return dio;
});
