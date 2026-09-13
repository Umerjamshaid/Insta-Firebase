import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta/features/auth/presentaion/cubits/auth_cubit.dart';
import 'package:insta/features/profile/presentation/Cubits/profile_states.dart';
import 'package:insta/features/profile/presentation/component/bio_box.dart';

import '../Cubits/profile_cubit.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final authCubit = context.read<AuthCubit>();

  //Current user
  late final currentUser = authCubit.currentUser;

  //Profile Cubit in here idk REALLY
  late final profileCubit = context.read<ProfileCubit>();

  //ON START UP THIS WILL RUN IDK BTW WHATS GOING TO RUN?????
  @override
  void initState() {
    super.initState();

    // Fetching the user profile when the screen is initialized!!! , YWAH SURE BUDDY TUFF ENGLISH I MEAN HOLY MOLY YOU RIDING IT HARD...... Puase.....
    profileCubit.fetchUserProfile(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        //Loaded
        if (state is ProfileLoadedState) {
          // Get the Loaded USers
          final profileUser = state.profileUser;

          return Scaffold(
            //Appbar
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    profileUser?.name ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                    size: 20,
                  ),
                ],
              ),
              foregroundColor: Theme.of(context).colorScheme.primary,
              actions: [
                //edit Profile
                IconButton(
                  onPressed: () {
                    if (profileUser == null) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditProfileScreen(user: profileUser),
                      ),
                    );
                  },
                  icon: Icon(Icons.settings),
                ),
                IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
              ],
            ),

            //BODY
            body: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //email
                Text(profileUser?.email ?? ''),
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      (profileUser?.profileImageUrl != null &&
                          profileUser!.profileImageUrl.isNotEmpty)
                      ? NetworkImage(profileUser.profileImageUrl)
                      : null,
                  child:
                      (profileUser?.profileImageUrl == null ||
                          profileUser!.profileImageUrl.isEmpty)
                      ? const Icon(Icons.person, size: 50)
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  profileUser?.name ?? '',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Bio',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                BioBox(text: profileUser!.bio),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 25),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Posts',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          );
        }
        //Loaded
        else if (state is ProfileLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                semanticsLabel: "Loading profile...",
              ),
            ),
          );
        }
        // Error handle
        else if (state is ProfileErrorState) {
          return Scaffold(
            body: Center(child: Text(state.message ?? "Something went wrong!")),
          );
        } //Fallback for ProfileInitialState or anything else
        else {
          return const Center(
            child: Text("Something went wrong! OR NO PROFILE baby.."),
          );
        }
      },
    );
  }
}
