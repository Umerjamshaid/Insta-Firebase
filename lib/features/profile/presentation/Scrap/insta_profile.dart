import 'package:flutter/material.dart';
import 'package:insta/features/profile/presentation/Scrap/components/profile_header.dart';
import 'package:insta/features/profile/presentation/Scrap/components/posts_grid.dart';
import 'package:insta/features/profile/presentation/Scrap/components/tab_bar_delegate.dart';

class InstagramProfileScreen extends StatelessWidget {
  const InstagramProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Text(
              'username_123',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 20),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              const SliverToBoxAdapter(child: ProfileHeader()),
              SliverPersistentHeader(
                pinned: true,
                delegate: TabBarDelegate(
                  const TabBar(
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(icon: Icon(Icons.grid_on)),
                      Tab(icon: Icon(Icons.assignment_ind_outlined)),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              // Grid View for Posts
              PostsGrid(),
              // Grid View for Tagged Posts
              Center(child: Text('Tagged Posts Screen')),
            ],
          ),
        ),
      ),
    );
  }
}
