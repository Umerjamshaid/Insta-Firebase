/*

profile repo baby YEAH!!!!!!!!!!!!!!!!
 */
import 'package:insta/features/profile/domain/entities/profile_user.dart';

abstract class ProfileRepo {
  Future<ProfileUser?> fetchUserProfile(String uid);
  Future<void> updatedProfile(ProfileUser updatedProfile);
}
