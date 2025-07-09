import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_with_bloc/src/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ProfileRepository{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  /// fetch data from firestore
  Future<UserModel> fetchUserDataFromFirestore() async {
    try {
      
      final userData = await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
      if(userData.data() != null){
        final user = UserModel.fromJson(userData.data()!);
        return user;
      }
      throw Exception("body null");
    } catch (e) {
      debugPrint("Google sign-in error: $e");
      throw Exception(e);
    }
  }
}