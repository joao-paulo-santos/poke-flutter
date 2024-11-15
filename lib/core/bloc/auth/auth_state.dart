import 'package:poke_flutter/core/models/user_credentials.dart';

class AuthState { }

class LoggedInAuthState extends AuthState{
  final UserCredentials credentials;

  LoggedInAuthState(this.credentials);
}

class GuestAuthState extends AuthState{ }

class LoadingAuthState extends AuthState{ }

class ErrorAuthState extends AuthState {
  final String? error;

  ErrorAuthState(this.error);
}