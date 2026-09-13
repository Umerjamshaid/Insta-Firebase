import 'package:flutter/material.dart';

class PostsGrid extends StatelessWidget {
  final int itemCount;

  const PostsGrid({Key? key, this.itemCount = 30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey[300],
          child: Image.network('https://picsum.photos', fit: BoxFit.cover),
        );
      },
    );
  }
}
