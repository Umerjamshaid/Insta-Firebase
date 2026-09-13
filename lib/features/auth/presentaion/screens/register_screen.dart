import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta/features/auth/presentaion/components/App_snack_bar.dart';
import 'package:insta/features/auth/presentaion/cubits/auth_cubit.dart';

import '../components/Text_feilds.dart';
import '../components/my_button.dart';
import '../components/or_divider.dart';

class RegisterScreen extends StatefulWidget {
  final void Function()? toggleScreen;

  const RegisterScreen({super.key, required this.toggleScreen});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //Texts feilds controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // register method
  register() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    final authCubit = context.read<AuthCubit>();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      AppSnackBar.showError(context, "Please fill in all fields.");
      return;
    }

    if (password != confirmPassword) {
      AppSnackBar.showError(context, "Passwords don't match.");
      return;
    }

    authCubit.register(name, email, password);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/register-outline.svg',
                    width: 100,
                    height: 100,
                  ),

                  SizedBox(height: 50),

                  //Create an account
                  Text(
                    "Nigga! Create An Account here",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 20,
                    ),
                  ),

                  SizedBox(height: 50),

                  //name text field
                  TextFeilds(
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.person_outline),
                    labelText: 'Name',
                    keyboardType: TextInputType.text,
                  ),

                  SizedBox(height: 15),

                  //email text field
                  TextFeilds(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.email_outlined),
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 15),

                  //password text field
                  TextFeilds(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock_outlined),
                    labelText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                  ),

                  SizedBox(height: 15),

                  //confirm password text field
                  TextFeilds(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock_outlined),
                    labelText: 'Confirm Password',
                  ),

                  SizedBox(height: 50),

                  //register button
                  MyButton(onTap: register, text: 'Register'),

                  SizedBox(height: 20),

                  OrDivider(),

                  SizedBox(height: 40),

                  //Already a member? Login here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already a member? ",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),

                      GestureDetector(
                        onTap: widget.toggleScreen,
                        child: Text(
                          "Login here",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
