import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta/features/profile/domain/entities/repos/profile_repo.dart';

import '../domain/entities/profile_user.dart';

class FirebaseProfileRepo implements ProfileRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async {
    try {
      //Get USers Docs FRom Firebase
      final userDoc = await firebaseFirestore
          .collection('users')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data();

        if (userData != null) {
          return ProfileUser(
            uid: uid,
            name: userData['name'] ?? '',
            email: userData['email'] ?? '',
            bio: userData['bio'] ?? '',
            profileImageUrl: userData['profileImageUrl'] ?? '',
          );
        }
        return null;
      }
    } catch (e) {
      print('🔥 Firestore error: $e');
      return null;
    }
  }

  @override
  Future<void> updatedProfile(ProfileUser updatedProfile) async {
    try {
      // convertUpdated Profile and show it  otusers, in firestore database
      await firebaseFirestore
          .collection('users')
          .doc(updatedProfile.uid)
          .update({
            'bio': updatedProfile.bio,
            'profileImageUrl': updatedProfile.profileImageUrl,
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
