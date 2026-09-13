import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final String text;

  const OrDivider({
    super.key,
    this.text = 'OR', // Default to uppercase for a clean UI look
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        // Left Divider Line
        Expanded(
          child: Divider(
            thickness: 1,
            color:
                colorScheme.primary, // Matches your unselected textfield border
          ),
        ),

        // "OR" Text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            text,
            style: TextStyle(
              color: colorScheme
                  .inversePrimary, // Matches your theme's primary color
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),

        // Right Divider Line
        Expanded(child: Divider(thickness: 1, color: colorScheme.primary)),
      ],
    );
  }
}
