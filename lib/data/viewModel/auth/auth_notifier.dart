import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tech_node/data/model/auth/auth_model.dart';
import 'package:tech_node/data/model/auth/auth_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tech_node/data/repository/auth/auth_repository.dart';
part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late FlutterSecureStorage _storage;
  @override
  AuthState build() {
    _storage = const FlutterSecureStorage(aOptions: AndroidOptions());
    Future.microtask(() => _checkPersistence());
    return AuthState(status: .loading);
  }

  Future<void> refreshUserstatus() async {
    state = AuthState(status: AuthStatus.loading);
    ref.invalidateSelf();
  }

  Future<void> _checkPersistence() async {
    final sessionJson = await _storage.read(key: 'user_session');
    if (sessionJson != null) {
      debugPrint('sessionJson------: ${jsonDecode(sessionJson)}');
    }
    try {
      if (sessionJson == null) {
        state = AuthState(status: AuthStatus.unauthenticated);
        return;
      }
      final auth = AuthModel.fromJson(jsonDecode(sessionJson));
      if (auth.authUser.isVerified == false) {
        state = AuthState(status: AuthStatus.unverified, authModel: auth);
      } else {
        state = AuthState(status: AuthStatus.authenticated, authModel: auth);
      }

    } catch (e) {
      state = AuthState(status: AuthStatus.unauthenticated);
    }
  }

  Future<void> authenticate(Future<AuthModel> authrepo) async {
    state = AuthState(status: AuthStatus.loading);
    try {
      await _storage.deleteAll();
      final result = await authrepo;
      await _storage.write(
        key: 'user_session',
        value: jsonEncode(result.toJson()),
      );
      if (result.authUser.isVerified == false) {
        state = AuthState(status: AuthStatus.unverified, authModel: result);
      } else {
        state = AuthState(status: AuthStatus.authenticated, authModel: result);
      }
    } catch (e) {
      state = AuthState(status: AuthStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> logout() async {
    state = AuthState(
      status: AuthStatus.loading,
      authModel: state.authModel,
      lastAction: AuthAction.logout,
    );
    try {
      await ref.read(authRepositoryProvider).logout();
      state = AuthState(
        status: AuthStatus.unauthenticated,
        lastAction: AuthAction.logout,
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: e.toString(),
        lastAction: AuthAction.logout,
      );
    } finally {
      await _storage.delete(key: 'user_session');
      state = AuthState(
        status: AuthStatus.unauthenticated,
        lastAction: AuthAction.logout,
      );
    }
  }

  Future<void> sendEmailVerification() async {
    state = AuthState(
      status: AuthStatus.loading,
      authModel: state.authModel,
      lastAction: AuthAction.emailVerification,
    );
    try {
      await ref.read(authRepositoryProvider).sendEmailVerification();
      state = AuthState(
        status: AuthStatus.unverified,
        authModel: state.authModel,
        lastAction: AuthAction.emailVerification,
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: e.toString(),
        authModel: state.authModel,
        lastAction: AuthAction.emailVerification,
      );
    }
  }

  Future<void> sendPasswordResetLink({required String email}) async {
    state = AuthState(
      status: AuthStatus.loading,
      lastAction: AuthAction.resetPasswordlink,
    );
    try {
      await ref
          .read(authRepositoryProvider)
          .sendPasswordResetLink(email: email);
      state = AuthState(
        status: AuthStatus.unauthenticated,
        lastAction: AuthAction.resetPasswordlink,
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: e.toString(),
        authModel: state.authModel,
      );
    }
  }

  Future<void> resetTheNewPassword({
    required String email,
    required String token,
    required String newPassword,
    required String newConPassword,
  }) async {
    state = AuthState(
      status: AuthStatus.loading,
      lastAction: AuthAction.resetPasswordPage,
    );
    try {
      await ref
          .read(authRepositoryProvider)
          .resetTheNewPassword(
            email: email,
            token: token,
            newPassword: newPassword,
            newConPassword: newConPassword,
          );
      state = AuthState(
        status: AuthStatus.unauthenticated,
        lastAction: AuthAction.resetPasswordPage,
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: e.toString(),
        authModel: state.authModel,
        lastAction: AuthAction.resetPasswordPage,
      );
    }
  }
}

@riverpod
String userRole(Ref ref) {
  final authstate = ref.watch(authProvider);
  return authstate.authModel?.authUser.role ?? 'guest';

}
