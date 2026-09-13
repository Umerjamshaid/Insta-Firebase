import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback? onEdit;
  final VoidCallback? onShare;

  const ActionButtons({Key? key, this.onEdit, this.onShare}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEFEFEF),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: onEdit ?? () {},
            child: const Text(
              'Edit profile',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEFEFEF),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: onShare ?? () {},
            child: const Text(
              'Share profile',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
