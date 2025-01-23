import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository _authRepository;

  SignUpBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const SignUpState()) {
    on<SignUpWithEmailEvent>(_onSignUpWithEmail);
    on<SignUpWithGoogleEvent>(_onSignUpWithGoogle);
    on<SignUpWithLinkedInEvent>(_onSignUpWithLinkedIn);
    on<SignUpWithAppleEvent>(_onSignUpWithApple);
  }

  Future<void> _onSignUpWithEmail(
    SignUpWithEmailEvent event,
    Emitter<SignUpState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      await _authRepository.signUpWithEmail(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
      );
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onSignUpWithGoogle(
    SignUpWithGoogleEvent event,
    Emitter<SignUpState> emit,
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

  Future<void> _onSignUpWithLinkedIn(
    SignUpWithLinkedInEvent event,
    Emitter<SignUpState> emit,
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

  Future<void> _onSignUpWithApple(
    SignUpWithAppleEvent event,
    Emitter<SignUpState> emit,
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
