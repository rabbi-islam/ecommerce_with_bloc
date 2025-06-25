
import 'package:bloc/bloc.dart';
import 'package:ecommerce_with_bloc/src/blocs/bloc_ecommerce_observer.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  Bloc.observer = BlocEcommerceObserver();
  runApp(const BlocEcommerceApp());
}