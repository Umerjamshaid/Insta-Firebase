import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta/features/auth/presentaion/components/Text_feilds.dart';
import 'package:insta/features/profile/domain/entities/profile_user.dart';
import 'package:insta/features/profile/presentation/Cubits/profile_cubit.dart';
import 'package:insta/features/profile/presentation/Cubits/profile_states.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileUser user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final bioTextController = TextEditingController();

  //Update profile Button
  void updateProfile() async {
    //Profile cubit
    final profileCubit = context.read<ProfileCubit>();

    if (bioTextController.text.isNotEmpty) {
      profileCubit.updateProfile(
        uid: widget.user.uid,
        newBio: bioTextController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (context, state) {
        // profile Loading..
        if (state is ProfileLoadingState) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Colors.blueGrey,
                    strokeWidth: 5,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Loading profile...",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        } else {
          //edit Form
          return buildEditScreen();
        }
      },
      listener: (context, state) {
        if (state is ProfileLoadedState) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget buildEditScreen({double uploadProgress = 0.0}) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          //Save button
          IconButton(onPressed: updateProfile, icon: const Icon(Icons.done)),
        ],
      ),

      //Body..
      body: Column(
        children: [
          //Profile Pic
          const SizedBox(height: 25),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(widget.user.profileImageUrl),
          ),

          //Bio
          const Text("Bio"),

          const SizedBox(height: 25),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextFeilds(
              controller: bioTextController,
              hintText: widget.user.bio,
              obscureText: false,
              prefixIcon: const Icon(Icons.edit),
            ),
          ),
        ],
      ),
    );
  }
}
