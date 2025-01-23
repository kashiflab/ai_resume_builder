import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginState()) {
    on<LoginWithEmailEvent>(_onLoginWithEmail);
    on<LoginWithGoogleEvent>(_onLoginWithGoogle);
    on<LoginWithLinkedInEvent>(_onLoginWithLinkedIn);
    on<LoginWithAppleEvent>(_onLoginWithApple);
  }

  Future<void> _onLoginWithEmail(
    LoginWithEmailEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      await _authRepository.signInWithEmail(
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoginWithGoogle(
    LoginWithGoogleEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      await _authRepository.signInWithGoogle();
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoginWithLinkedIn(
    LoginWithLinkedInEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      await _authRepository.signInWithLinkedIn();
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoginWithApple(
    LoginWithAppleEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      await _authRepository.signInWithApple();
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
