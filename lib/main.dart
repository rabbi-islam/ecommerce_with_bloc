import 'package:bloc/bloc.dart';
import 'package:ecommerce_with_bloc/src/blocs/bloc_ecommerce_observer.dart';
import 'package:ecommerce_with_bloc/src/data/preference/local_preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = BlocEcommerceObserver();
  await LocalPreferences().init();
  runApp(const BlocEcommerceApp());
}