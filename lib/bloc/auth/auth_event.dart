part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class AuthLoginEvent extends AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}

class AutSetCurrentUserEvent extends AuthEvent {
  final UserInfo userInfo;

  const AutSetCurrentUserEvent(this.userInfo);

  @override
  List<Object> get props => [userInfo];
}
