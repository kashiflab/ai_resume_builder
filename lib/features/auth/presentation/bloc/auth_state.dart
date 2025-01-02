part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final UserModel? user;
  final bool isAuthenticated;
  final bool isLoading;
  final String? errorMessage;
  final bool isInitialState;
  final bool signUpSuccess;

  const AuthState({
    this.user,
    this.isAuthenticated = false,
    this.isLoading = false,
    this.errorMessage,
    this.isInitialState = false,
    this.signUpSuccess = false,
  });

  AuthState copyWith({
    UserModel? user,
    bool? isAuthenticated,
    bool? isLoading,
    String? errorMessage,
    bool? isInitialState,
    bool? signUpSuccess,
  }) {
    return AuthState(
      user: user ?? this.user,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isInitialState: isInitialState ?? this.isInitialState,
      signUpSuccess: signUpSuccess ?? this.signUpSuccess,
    );
  }

  @override
  List<Object?> get props => [
        user,
        isAuthenticated,
        isLoading,
        errorMessage,
        isInitialState,
        signUpSuccess,
      ];
}
