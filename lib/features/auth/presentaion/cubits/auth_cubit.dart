/*

    Auth Cubit: State management too

 */

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta/features/auth/domain/entities/app_user.dart';
import 'package:insta/features/auth/domain/repos/auth_repo.dart';
import 'package:insta/features/auth/presentaion/cubits/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitialState());

  // Check if user is already logged in
  void checkAuthStatus() async {
    final AppUser? user = await authRepo.getCurrentUser();
    if (user != null) {
      _currentUser = user;
      emit(AuthenticatedState(user));
    } else {
      emit(UnauthenticatedState());
    }
  }

  // Get Current User
  AppUser? get currentUser => _currentUser;

  // Login with email and password
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoadingState());

      final user = await authRepo.loginWithEmailPassword(email, password);
      if (user != null) {
        _currentUser = user;
        emit(AuthenticatedState(user));
      } else {
        emit(UnauthenticatedState());
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
      emit(UnauthenticatedState());
    }
  }

  // Register with email and password
  Future<void> register(String name, String email, String password) async {
    try {
      emit(AuthLoadingState());

      final user = await authRepo.registerWithEmailPassword(
        name,
        email,
        password,
      );
      if (user != null) {
        _currentUser = user;
        emit(AuthenticatedState(user));
      } else {
        emit(UnauthenticatedState());
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
      emit(UnauthenticatedState());
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      emit(AuthLoadingState());
      await authRepo.logout();
      _currentUser = null;
      emit(UnauthenticatedState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));
      emit(UnauthenticatedState());
    }
  }
}
