part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestEmailSignup extends SignupEvent {
  final String username;
  final String email;
  final String password;
  final String confirmsPassword;

  RequestEmailSignup({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmsPassword,
  });

  @override
  List<Object?> get props => [username,email, password, confirmsPassword];
}
