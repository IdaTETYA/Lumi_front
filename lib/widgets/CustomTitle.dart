import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Center(
          child: Text(
            subtitle,
            style: const TextStyle(fontSize: 16,color:Colors.black54),

          ),
        ),
      ],
    );
  }
}