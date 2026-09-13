import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta/features/profile/presentation/screens/profile_screen.dart';

import '../../../auth/presentaion/components/or_divider.dart';
import '../../../auth/presentaion/cubits/auth_cubit.dart';
import 'drawer_tile.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Icon(
                  Icons.local_airport,
                  size: 60,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              //Divider
              OrDivider(text: 'Check it out'),

              // home tile
              DrawerTile(
                title: "H O M E",
                icon: Icons.home_max,
                ontap: () => Navigator.of(context).pop(),
              ),

              // profile tile
              DrawerTile(
                title: "P R O F I L E",
                icon: Icons.person_outline_rounded,
                ontap: () {
                  //Menu POP ASDA SDasdasdkl
                  Navigator.of(context).pop();

                  //Need current users id baby
                  final userId = context.read<AuthCubit>().currentUser;
                  String? uid = userId?.uid;

                  // Drwaer to nav to profile
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(uid: uid!),
                    ),
                  );
                },
              ),

              // search tile
              DrawerTile(
                title: "S E A R C H",
                icon: Icons.search_rounded,
                ontap: () {},
              ),

              // settings tile
              DrawerTile(
                title: "S E T T I N G S",
                icon: Icons.settings_suggest_rounded,
                ontap: () {},
              ),

              const Spacer(),

              // logout tile
              DrawerTile(
                title: "L O G O U T",
                icon: Icons.door_back_door,
                ontap: () => context.read<AuthCubit>().logout(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
