
import 'package:bloc/bloc.dart';
import 'package:ecommerce_with_bloc/src/data/repository/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository repository;

  LoginBloc(this.repository) : super(LoginInitial()) {


    on<RequestGoogleLogin>((event, emit) async{
      try{
        emit(LoginLoading());
        final user = await repository.signInWithGoogle();
          debugPrint('User: ${user?.displayName}');
          emit(LoginSuccess());

      }catch(e){
        debugPrint(e.toString());
        emit(LoginFailed('Found error => ${e.toString()}'));
      }
    });

    on<RequestEmailLogin>((event, emit) async{
      debugPrint("Email: ${event.email}, Password: ${event.password}, Remember: ${event.isRemember}");
      try{
        emit(LoginLoading());
        await repository.signInWithEmail(event.email, event.password).then((value) => emit(LoginSuccess()));

      }catch(e){
        debugPrint(e.toString());
        emit(LoginFailed('Found error => ${e.toString()}'));
        emit(LoginInitial());
      }
    });

    on<RequestSignOut>((event, emit) async{
      try{
        await repository.signOut().then((value)=>emit(SignOutSuccess()));

      }catch(e){
        debugPrint(e.toString());
        emit(SignOutFailed('Found error => ${e.toString()}'));
      }

    });


  }
}

