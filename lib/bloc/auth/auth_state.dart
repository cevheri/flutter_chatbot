part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final bool isPasswordVisible;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isLogin;
  final bool isFailure;
  final String error;
  final String currentUser;

  const AuthState({
    required this.isLoading,
    required this.isPasswordVisible,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isLogin,
    required this.isFailure,
    required this.error,
    this.currentUser = '',
  });

  factory AuthState.initial() {
    return const AuthState(
      isLoading: false,
      isPasswordVisible: false,
      isSubmitting: false,
      isSuccess: false,
      isLogin: false,
      isFailure: false,
      error: '',
      currentUser: '',
    );
  }

  AuthState copyWith({
    bool? isLoading,
    bool? isPasswordVisible,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isLogin,
    bool? isFailure,
    String? error,
    String? currentUser,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isLogin: isLogin ?? this.isLogin,
      isFailure: isFailure ?? this.isFailure,
      error: error ?? this.error,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  List<Object> get props => [isLoading, isPasswordVisible, isSubmitting, isSuccess, isLogin, isFailure, error,  currentUser];

  @override
  bool get stringify => true;
}