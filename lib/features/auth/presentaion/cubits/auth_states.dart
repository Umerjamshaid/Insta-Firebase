/*

 The Auth States - Outlines  the possible auth States Management

 */
import 'package:insta/features/auth/domain/entities/app_user.dart';

abstract class AuthState {}

// initial state
class AuthInitialState extends AuthState {}

// Loading state
class AuthLoadingState extends AuthState {}

//Authentication state
class AuthenticatedState extends AuthState {
  final AppUser user;
  AuthenticatedState(this.user);
}

//Unauthenticated state
class UnauthenticatedState extends AuthState {}

//Errors
class AuthErrorState extends AuthState {
  final String message;
  AuthErrorState(this.message);
}
