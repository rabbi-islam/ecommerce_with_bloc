
import 'package:bloc/bloc.dart';
import 'package:ecommerce_with_bloc/src/data/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  AuthRepository repository;
  SignupBloc(this.repository) : super(SignupInitial()) {
    on<RequestEmailSignup>((event, emit) async {

      emit(SignupLoading());
      try {
        await repository.signUpWithEmail(event.email, event.password, event.username);
        emit(SignupSuccess());
      }catch (e) {
        emit(SignupFailed(message: e.toString()));
        emit(SignupInitial());
      }

    });
  }
}
