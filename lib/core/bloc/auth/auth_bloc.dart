import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poke_flutter/core/bloc/auth/auth_event.dart';
import 'package:poke_flutter/core/bloc/auth/auth_state.dart';
import 'package:poke_flutter/core/services/auth_service.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  AuthBloc(this._authService) : super(GuestAuthState()){
    on<LoginEvent>((event, emit) async {
      emit(LoadingAuthState());
      await Future.delayed(const Duration(seconds: 1));
      try{
        final credentials = _authService.login(event.username, event.password);
        emit(LoggedInAuthState(credentials));
      }
      catch (error) {
        emit(ErrorAuthState(error.toString()));
      }
    });
    on<LogoutEvent>((event, emit) {
      emit(GuestAuthState());
    });
  }
}