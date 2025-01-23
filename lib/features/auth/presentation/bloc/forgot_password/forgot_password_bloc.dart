import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository _authRepository;

  ForgotPasswordBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const ForgotPasswordState()) {
    on<SendResetPasswordEmailEvent>(_onSendResetPasswordEmail);
  }

  Future<void> _onSendResetPasswordEmail(
    SendResetPasswordEmailEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      await _authRepository.sendPasswordResetEmail(email: event.email);
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
