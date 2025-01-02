part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}

class SignInWithEmailEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInWithEmailEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class SignUpWithEmailEvent extends AuthEvent {
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

class SignInWithGoogleEvent extends AuthEvent {
  const SignInWithGoogleEvent();
}

class SignInWithLinkedInEvent extends AuthEvent {
  const SignInWithLinkedInEvent();
}

class SignInWithAppleEvent extends AuthEvent {
  const SignInWithAppleEvent();
}

class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}

class UpdateProfileEvent extends AuthEvent {
  final UserModel user;

  const UpdateProfileEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class ResetPasswordEvent extends AuthEvent {
  final String email;

  const ResetPasswordEvent({required this.email});

  @override
  List<Object?> get props => [email];
}
