import 'package:bloc/bloc.dart';
import 'package:ecommerce_with_bloc/src/data/repository/store_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void startSplash() async{
    Future.delayed(Duration(seconds: 5), (){
      emit(SplashEnd());
    });
  }
}
