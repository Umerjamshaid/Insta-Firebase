import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta/features/profile/domain/entities/repos/profile_repo.dart';
import 'package:insta/features/profile/presentation/Cubits/profile_states.dart';
import 'package:insta/features/storage/domain/storage_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  final StorageRepo storageRepo;

  ProfileCubit({required this.profileRepo, required this.storageRepo})
    : super(ProfileInitialState());

  // Fetch USers funtions etc
  Future<void> fetchUserProfile(String uid) async {
    try {
      emit(ProfileLoadingState());
      final user = await profileRepo.fetchUserProfile(uid);

      if (user != null) {
        emit(ProfileLoadedState(user));
      } else {
        emit(ProfileErrorState("Something went wrong! pls Try Again....."));
      }
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  //Update Bio or Profules pocs
  Future<void> updateProfile({
    required String uid,
    String? newBio,
    Uint8List? imageWebBytes,
    String? imageMobilPath,
  }) async {
    emit(ProfileLoadingState());

    try {
      //Fetching Current Profile to show on front
      final currentUser = await profileRepo.fetchUserProfile(uid);

      if (currentUser == null) {
        emit(ProfileErrorState("No PfP Found By this Fucking name"));
        return;
      }
      //profile pic update
      String? imageDownloadUrl;

      //Upload image to storage making sure there is profile pic to upload
      if (imageWebBytes != null || imageMobilPath != null) {
        //for mobile
        if (imageMobilPath != null) {
          imageDownloadUrl = await storageRepo.uploadProfileImageMobil(
            imageMobilPath,
            currentUser.uid,
          );
        }

        //for web
      }

      /// Update new profiles gpp
      final updatedProfile = currentUser.copyWith(
        newBio: newBio ?? currentUser.bio,
      );

      //Update in repo
      await profileRepo.updatedProfile(updatedProfile);

      //RE Fectch UPDTATED PROFILE baby
      await fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileErrorState("Error Updateing this_Shitty_Ass_PROFILE $e"));
    }
  }
}
