part of 'signup_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpWithEmailEvent extends SignUpEvent {
  final String email;
  final String password;
  final String fullName;

  const SignUpWithEmailEvent({
    required this.email,
    required this.password,
    required this.fullName,
  });

  @override
  List<Object?> get props => [email, password, fullName];
}

class SignUpWithGoogleEvent extends SignUpEvent {
  const SignUpWithGoogleEvent();
}

class SignUpWithLinkedInEvent extends SignUpEvent {
  const SignUpWithLinkedInEvent();
}

class SignUpWithAppleEvent extends SignUpEvent {
  const SignUpWithAppleEvent();
}
