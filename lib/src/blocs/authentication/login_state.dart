part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  List<Object?> get props => [emailController, passwordController];
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailed extends LoginState {
  final String errorMessage;

  LoginFailed(this.errorMessage);
}

class SignOutSuccess extends LoginState {}

class SignOutFailed extends LoginState {
  final String message;
  SignOutFailed(this.message);
  @override
  List<Object?> get props => [message];
}
