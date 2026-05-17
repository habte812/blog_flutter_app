import 'package:tech_node/data/model/auth/auth_model.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  unverified,
  error,
}

enum AuthAction {
  none,
  login,
  rigister,
  emailVerification,
  logout,
  resetPasswordlink,
  resetPasswordPage
}

class AuthState {
  final AuthStatus status;
  final AuthModel? authModel;
  final String? errorMessage;
  final AuthAction? lastAction;

  AuthState({
    required this.status,
    this.authModel,
    this.errorMessage,
    this.lastAction
  });

  factory AuthState.initial() => AuthState(status: AuthStatus.initial);
}
