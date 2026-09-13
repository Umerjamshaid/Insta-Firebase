import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta/features/auth/presentaion/components/Text_feilds.dart';
import 'package:insta/features/auth/presentaion/components/my_button.dart';
import 'package:insta/features/auth/presentaion/components/or_divider.dart';
import 'package:insta/features/auth/presentaion/cubits/auth_cubit.dart';

import '../components/App_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? toggleScreen;

  const LoginScreen({super.key, required this.toggleScreen});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Texts feilds controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //login Logic here ----:

  void login() {
    //email and passwords controller
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    //Auth cubit for functions to be called here
    final authCubit = context.read<AuthCubit>();

    // here making sure that passwords and email arent empty
    if (email.isNotEmpty && password.isNotEmpty) {
      authCubit.login(email, password);
    } else {
      // else display an error
      // AppSnackBar.showError(context, 'Please enter both email and password.');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both email and password.'),
          backgroundColor: const Color(0xFF66CF70),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/lock_open_rounded.svg',
                        width: 100,
                        height: 100,
                        colorFilter: ColorFilter.mode(
                          ColorScheme.of(context).primary,
                          BlendMode.srcIn,
                        ),
                      ),

                      SizedBox(height: 50),

                      //Welcome message
                      Text(
                        "Welcome back Nigga",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 20,
                        ),
                      ),

                      SizedBox(height: 50),

                      //email text field
                      TextFeilds(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email_outlined),
                        labelText: 'Email',
                      ),

                      SizedBox(height: 15),

                      //password text field
                      TextFeilds(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const Icon(Icons.lock_outlined),
                        labelText: 'Password',
                      ),

                      SizedBox(height: 50),

                      //login button
                      MyButton(onTap: login, text: 'Login'),

                      SizedBox(height: 20),

                      OrDivider(),

                      SizedBox(height: 40),

                      //not a member? register here
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Not a member? ",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),

                          GestureDetector(
                            onTap: widget.toggleScreen,
                            child: Text(
                              "Register here",
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.inversePrimary,
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
        ),
      ),
    );
  }
}
