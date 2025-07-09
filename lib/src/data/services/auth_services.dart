import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  bool checkLoginStatus() {
    final user = _firebaseAuth.currentUser;

    if(user != null){
      return true;
    }else {
      return false;
    }
  }
}
