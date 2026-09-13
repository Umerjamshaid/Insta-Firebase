import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta/features/auth/data/firebase_auth_repo.dart';
import 'package:insta/features/auth/presentaion/components/App_snack_bar.dart';
import 'package:insta/features/auth/presentaion/cubits/auth_cubit.dart';
import 'package:insta/features/auth/presentaion/cubits/auth_states.dart';
import 'package:insta/features/profile/data/firebase_profile_repo.dart';
import 'package:insta/features/profile/presentation/Cubits/profile_cubit.dart';
import 'package:insta/features/storage/data/firebase_storage_repo.dart';
import 'package:insta/themes/ligth_mode.dart';

import 'features/auth/presentaion/screens/auth_screen.dart';
import 'features/home/presentation/screens/home_screen.dart';

/*
APP — Root Level

Repositories: for the database
  - firebase

Bloc Providers: for state management
  - auth
  - profile
  - post
  - search
  - theme

Check Auth State
  - unauthenticated -> auth Screen (login/register)
  - authenticated -> homeScreen
*/

class MyApp extends StatelessWidget {
  final firebaseAuthRepo = FirebaseAuthRepo();

  final firebaseProfileRepo = FirebaseProfileRepo();

  final firebaseStorageRepo = FirebaseStorageRepo();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Provide cubit to our app
    return MultiBlocProvider(
      providers: [
        ///Auth Cubit
        BlocProvider<AuthCubit>(
          create: (context) =>
              AuthCubit(authRepo: firebaseAuthRepo)..checkAuthStatus(),
        ),

        /// Profile Cubit
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(
            profileRepo: firebaseProfileRepo,
            storageRepo: firebaseStorageRepo,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Insta Clone',
        debugShowCheckedModeBanner: false,
        theme: ligthMode,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            print(authState);

            // - unauthenticated -> auth Screen (login/register)
            if (authState is UnauthenticatedState) {
              return const AuthScreen();
            }

            // - authenticated -> homeScreen
            if (authState is AuthenticatedState) {
              return const HomeScreen();
            }
            //Loading
            else {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
          listener: (context, state) {
            if (state is AuthErrorState) {
              AppSnackBar.showError(context, state.message);
            }
          },
        ),
      ),
    );
  }
}
