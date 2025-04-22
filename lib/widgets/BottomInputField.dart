import 'package:flutter/material.dart';
import '../utils/constants.dart';

class BottomInputField extends StatefulWidget {
  final Function(String) onSubmitted;

  const BottomInputField({
    super.key,
    required this.onSubmitted,
  });

  @override
  _BottomInputFieldState createState() => _BottomInputFieldState();
}

class _BottomInputFieldState extends State<BottomInputField> {
  final _textController = TextEditingController();
  bool _isTextNotEmpty = false; // État pour suivre si le texte est non vide

  @override
  void initState() {
    super.initState();
    // Ajouter un écouteur pour surveiller les changements dans le TextField
    _textController.addListener(() {
      setState(() {
        _isTextNotEmpty = _textController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      widget.onSubmitted(text);
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.image,
              color: Colors.black,
              size: 24,
            ),
            onPressed: () {
              print('Ajouter une image');
            },
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Poser une question...',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                border: InputBorder.none,

              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  widget.onSubmitted(value);
                  _textController.clear();
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(
              _isTextNotEmpty ? Icons.send : Icons.mic, // Afficher "Envoyer" si le texte n'est pas vide, sinon "Micro"
              color: Colors.black,
              size: 24,
            ),
            onPressed: _isTextNotEmpty
                ? _handleSend // Appeler _handleSend si l'icône est "Envoyer"
                : () {
              print('Activer le microphone');
            },
          ),
        ],
      ),
    );
  }
}