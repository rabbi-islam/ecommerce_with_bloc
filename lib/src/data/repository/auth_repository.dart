import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignIn = await GoogleSignIn().signIn();
      if (googleSignIn == null) {
        // User canceled the sign-in process
        debugPrint("User canceled the signin process.");
        return null;
      }
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignIn.authentication;

      debugPrint("Access Token: ${googleSignInAuthentication.accessToken}");
      debugPrint("ID Token: ${googleSignInAuthentication.idToken}");

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult =
      await _auth.signInWithCredential(credential);
      debugPrint('User: ${authResult.user?.email}');


      return authResult.user;
    } catch (error) {
      debugPrint("Error signing in with Google: $error");
      throw Exception(error);
    }
  }

}
