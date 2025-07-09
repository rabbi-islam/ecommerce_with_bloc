part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestGoogleLogin extends LoginEvent{}
class RequestEmailLogin extends LoginEvent{
  final String email;
  final String password;
  final bool isRemember;
  RequestEmailLogin(this.email, this.password, this.isRemember);

  @override
  List<Object?> get props => [email, password, isRemember];
}
class RequestSignOut extends LoginEvent{}