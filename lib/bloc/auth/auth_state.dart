part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final UserInfo? userInfo;
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final String error;

  const AuthState(
    this.userInfo, {
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    required this.error,
  });

  factory AuthState.initial() {
    return const AuthState(
      null,
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      error: '',
    );
  }

  AuthState copyWith({
    UserInfo? userInfo,
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    String? error,
  }) {
    return AuthState(
      userInfo ?? this.userInfo,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [userInfo!, isLoading, isSuccess, isFailure, error];

  @override
  bool get stringify => true;
}
