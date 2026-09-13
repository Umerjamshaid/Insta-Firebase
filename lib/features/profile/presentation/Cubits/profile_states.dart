/*

Profile Sates lol

 */
import 'package:insta/features/profile/domain/entities/profile_user.dart';

abstract class ProfileState {}

//initial States
class ProfileInitialState extends ProfileState {}

//Loading States
class ProfileLoadingState extends ProfileState {}

//Loaded sataes etc
class ProfileLoadedState extends ProfileState {
  final ProfileUser? profileUser;
  ProfileLoadedState(this.profileUser);
}

//Error
class ProfileErrorState extends ProfileState {
  final String? message;
  ProfileErrorState(this.message);
}
