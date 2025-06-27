import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_with_bloc/src/data/repository/repository.dart';
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
  }
}
