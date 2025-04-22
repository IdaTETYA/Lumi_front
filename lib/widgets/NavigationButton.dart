// lib/widgets/NavigationButton.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class NavigationButtons extends StatelessWidget {
  final VoidCallback? onPreviousPressed;
  final VoidCallback? onNextPressed;
  final bool isNextEnabled;

  const NavigationButtons({
    super.key,
    this.onPreviousPressed,
    this.onNextPressed,
    this.isNextEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), // Coins arrondis
            color: onPreviousPressed != null ? Colors.white : const Color(0xFFF8F9FD),
            border: onPreviousPressed != null
                ? Border.all(color: Colors.grey.shade300)
                : null,
            boxShadow: onPreviousPressed != null
                ? [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ]
                : null,
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: onPreviousPressed != null ? Colors.black : Colors.grey,
            ),
            onPressed: onPreviousPressed,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), // Coins arrondis
            color: isNextEnabled ? Colors.white : const Color(0xFFF8F9FD),
            border: isNextEnabled ? Border.all(color: Colors.grey.shade300) : null,
            boxShadow: isNextEnabled
                ? [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ]
                : null,
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: isNextEnabled ? Colors.black : Colors.grey,
            ),
            onPressed: isNextEnabled ? onNextPressed : null,
          ),
        ),
      ],
    );
  }
}