// lib/widgets/create_account_section.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CreateAccountSection extends StatelessWidget {
  const CreateAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Ajusté à 16.0 pour correspondre au design
      decoration: BoxDecoration(
        color: AppConstants.sectionBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Texte à gauche, image à droite
        crossAxisAlignment: CrossAxisAlignment.center, // Centre verticalement
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Minimise l'espace vertical
              children: [
                const Text(
                  'Pas encore de compte ?',
                  style: TextStyle(fontSize: AppConstants.hintTextSize),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/typeCompte');
                  },
                  child: Text(
                    'Créer un compte',
                    style: TextStyle(
                      fontSize: AppConstants.linkTextSize,
                      color: AppConstants.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Image alignée à droite
          Image.asset(
            'assets/imageFemme.png',
            width: 120,
            height: 120,
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    );
  }
}