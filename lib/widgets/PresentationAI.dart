import 'package:flutter/material.dart';

class PresentationAI extends StatelessWidget {
  final Function(String) onSubmitted;

  const PresentationAI({super.key, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: () {
              // Action pour ajouter une image
            },
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Poser une question...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onSubmitted: (value) {
                print('Message soumis via Entrée : $value');
                if (value.trim().isNotEmpty) {
                  onSubmitted(value);
                  controller.clear();
                }
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final value = controller.text;
              print('Message soumis via bouton : $value');
              if (value.trim().isNotEmpty) {
                onSubmitted(value);
                controller.clear();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.mic),
            onPressed: () {
              // Action pour la reconnaissance vocale
            },
          ),
        ],
      ),
    );
  }
}