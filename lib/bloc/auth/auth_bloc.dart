

import 'dart:async';

import 'package:dnext_chatbot/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openid_client/openid_client.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// Keycloak Auth Bloc with openid_client
class AuthBloc extends Bloc<AuthEvent, AuthState> {


  AuthBloc({required this.authRepository}) : super(AuthState.initial()) {
    on<AuthLoginEvent>(_onLogin);
    on<AuthLogoutEvent>(_onLogout);
    on<AutSetCurrentUserEvent>(_onSetCurrentUser);
  }

  final AuthRepository authRepository;

  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    print('Bloc Login.Start');
    emit(state.copyWith(isLoading: true));
    try {
      print('Bloc Login');
     var result = await authRepository.login().then((value) => {
        print('Bloc Login.ID Token: ${value.idToken}'),
        print('bloc Login.User Info: ${value.accessToken}')
     });
      print('Bloc Login.Result: $result');
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isFailure: true, error: e.toString()));
    }
    print('Bloc Login.End');
  }

  Future<void> _onLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await authRepository.logout();
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isFailure: true, error: e.toString()));
    }
  }

  FutureOr<void> _onSetCurrentUser(AutSetCurrentUserEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(userInfo: event.userInfo, isLoading: false, isSuccess: true, isFailure: false, error: ''));
  }
}