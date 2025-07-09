part of 'signup_bloc.dart';

@immutable
abstract class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  List<Object?> get props => [userNameController, emailController, passwordController, confirmPasswordController];
}

class SignupLoading extends SignupState{}
class SignupSuccess extends SignupState{}
class SignupFailed extends SignupState{
  final String message;
  SignupFailed({required this.message});

  @override
  List<Object?> get props => [message];

}

