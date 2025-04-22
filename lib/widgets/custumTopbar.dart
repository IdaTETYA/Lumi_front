import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showMenuIcon;
  final String title;
  final bool showTitle;
  final bool showCreateIcon;
  final bool showSettingsIcon;
  final VoidCallback? onSettingsPressed;
  final VoidCallback? onCreatePressed; // Ajout de la fonction de rappel
  final bool hasMessages;

  const TopBar({
    super.key,
    required this.showMenuIcon,
    required this.title,
    required this.showTitle,
    required this.showCreateIcon,
    required this.showSettingsIcon,
    this.onSettingsPressed,
    this.onCreatePressed, // Ajout du paramètre
    this.hasMessages = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: showMenuIcon
          ? IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      )
          : null,
      title: hasMessages || showTitle
          ? Center(
        child: Image.asset(
          'assets/lumi.png',
          width: 50,
          height: 50,
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
      )
          : null,
      centerTitle: true,
      actions: [
        if (hasMessages)
          IconButton(
            icon: const Icon(Icons.create, color: Colors.black),
            onPressed: onCreatePressed, // Utilisation de la fonction de rappel
          ),
        if (showSettingsIcon)
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: onSettingsPressed,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}