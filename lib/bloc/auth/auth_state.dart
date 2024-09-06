part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final bool isPasswordVisible;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String error;

  const AuthState({
    required this.isLoading,
    required this.isPasswordVisible,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    required this.error,
  });

  factory AuthState.initial() {
    return const AuthState(
      isLoading: false,
      isPasswordVisible: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      error: '',
    );
  }

  AuthState copyWith({
    bool? isLoading,
    bool? isPasswordVisible,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [isLoading, isPasswordVisible, isSubmitting, isSuccess, isFailure, error];

  @override
  bool get stringify => true;
}