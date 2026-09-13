import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:insta/features/auth/domain/repos/auth_repo.dart';

import '../domain/entities/app_user.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      //Attempt login
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      //creating user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: '',
      );

      //return User
      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
    String username,
    String email,
    String password,
  ) async {
    try {
      //Attempt register account
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      //creating user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: username,
      );

      //Saves users to firestore lol!
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(user.toJson());

      //return User
      return user;
    } catch (e) {
      throw Exception('Register failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    // Get Crrunt users from frebase
    final firebaseUser = firebaseAuth.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    // user exist then

    return AppUser(uid: firebaseUser.uid, email: firebaseUser.email!, name: '');
  }
}
