import 'package:flutter/material.dart';
import 'package:insta/features/profile/presentation/Scrap/components/stats_item.dart';
import 'package:insta/features/profile/presentation/Scrap/components/action_buttons.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Pic and Stats
          Row(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage('https://placeholder.co'),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    StatsItem(count: '120', label: 'Posts'),
                    StatsItem(count: '14.2k', label: 'Followers'),
                    StatsItem(count: '345', label: 'Following'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Name and Bio
          const Text(
            'Display Name',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Text(
            'Digital Creator 🚀\nBuilding sleek Flutter applications.\n✨ Code is poetry.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 15),
          // Action Buttons
          const ActionButtons(),
        ],
      ),
    );
  }
}
