import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository)
      : super(const AuthState(isInitialState: true)) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<SignInWithEmailEvent>(_onSignInWithEmail);
    on<SignUpWithEmailEvent>(_onSignUpWithEmail);
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignInWithLinkedInEvent>(_onSignInWithLinkedIn);
    on<SignInWithAppleEvent>(_onSignInWithApple);
    on<SignOutEvent>(_onSignOut);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _authRepository.getCurrentUser();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        user: null,
        errorMessage: null,
      )),
      (user) => emit(state.copyWith(
        isLoading: false,
        isAuthenticated: user != null,
        user: user,
        errorMessage: null,
      )),
    );
  }

  Future<void> _onSignInWithEmail(
    SignInWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _authRepository.signInWithEmail(
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (user) => emit(state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: user,
        errorMessage: null,
      )),
    );
  }

  Future<void> _onSignUpWithEmail(
    SignUpWithEmailEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _authRepository.signUpWithEmail(
      email: event.email,
      password: event.password,
      fullName: event.fullName,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (user) => emit(state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        user: null,
        errorMessage: null,
        signUpSuccess: true,
      )),
    );
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _authRepository.signInWithGoogle();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (user) => emit(state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: user,
        errorMessage: null,
      )),
    );
  }

  Future<void> _onSignInWithLinkedIn(
    SignInWithLinkedInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _authRepository.signInWithLinkedIn();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (user) => emit(state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: user,
        errorMessage: null,
      )),
    );
  }

  Future<void> _onSignInWithApple(
    SignInWithAppleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _authRepository.signInWithApple();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (user) => emit(state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: user,
        errorMessage: null,
      )),
    );
  }

  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _authRepository.signOut();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        user: null,
        errorMessage: null,
      )),
    );
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _authRepository.updateProfile(user: event.user);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (user) => emit(state.copyWith(
        isLoading: false,
        user: user,
        errorMessage: null,
      )),
    );
  }

  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _authRepository.resetPassword(email: event.email);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        isLoading: false,
        errorMessage: null,
      )),
    );
  }
}
