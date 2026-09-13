/*

This Screen is purely for what to show, login or register

 */
import 'package:flutter/material.dart';
import 'package:insta/features/auth/presentaion/screens/login_screen.dart';
import 'package:insta/features/auth/presentaion/screens/register_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // initially We wil show Login screen
  bool showLoginScreen = true;

  //here we will toggle b/t screen
  void toggleScreens() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(toggleScreen: toggleScreens);
    } else {
      return RegisterScreen(toggleScreen: toggleScreens);
    }
  }
}
