part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginWithEmailEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginWithEmailEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class LoginWithGoogleEvent extends LoginEvent {
  const LoginWithGoogleEvent();
}

class LoginWithLinkedInEvent extends LoginEvent {
  const LoginWithLinkedInEvent();
}

class LoginWithAppleEvent extends LoginEvent {
  const LoginWithAppleEvent();
}
