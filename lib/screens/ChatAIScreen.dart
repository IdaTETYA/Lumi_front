import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import '../widgets/PresentationAI.dart';
import '../widgets/CustomTextField.dart';
import '../widgets/MessageList.dart';
import '../widgets/custumTopbar.dart';

class ChatAIScreen extends StatefulWidget {
  const ChatAIScreen({super.key});

  @override
  _LumiScreenState createState() => _LumiScreenState();
}

class _LumiScreenState extends State<ChatAIScreen> {
  final List<Map<String, dynamic>> messages = [];
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? 'Utilisateur';
    });
  }

  void _handleMessageSubmitted(String message) {
    setState(() {
      messages.add({
        'text': message,
        'isUser': true,
      });
      messages.add({
        'text': 'Salut ! Je peux t\'aider avec ça. Que veux-tu savoir ?',
        'isUser': false,
      });
      print('Messages après ajout : $messages');
      print('hasMessages : ${messages.isNotEmpty}');
    });
  }

  void _resetConversation() {
    setState(() {
      messages.clear(); // Réinitialiser la liste des messages
      print('Conversation réinitialisée');
    });
  }

  Widget _buildInitialScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/lumi.png',
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 16),
          const Text(
            'Comment puis-je vous aider ?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _buildButton(
                text: 'poser des questions sur votre grossesse',
                icon: Icons.pregnant_woman,
                onTap: () {
                  _handleMessageSubmitted('Questions sur la grossesse');
                },
              ),
              _buildButton(
                text: 'Demander des conseils',
                icon: Icons.warning,
                color: Colors.red,
                onTap: () {
                  _handleMessageSubmitted('Demander des conseils');
                },
              ),
              _buildButton(
                text: 'Recevez une assistance',
                icon: Icons.favorite,
                color: Colors.green,
                onTap: () {
                  _handleMessageSubmitted('Recevoir une assistance');
                },
              ),
              _buildButton(
                text: 'Un suivi personnalisé',
                icon: Icons.person,
                onTap: () {
                  _handleMessageSubmitted('Suivi personnalisé');
                },
              ),
              _buildButton(
                text: 'plus',
                icon: Icons.add,
                onTap: () {
                  _handleMessageSubmitted('Plus');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required IconData icon,
    Color? color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color ?? Colors.black, size: 20),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopBar(
        key: ValueKey(messages.isNotEmpty), // Forcer la reconstruction
        showMenuIcon: true,
        title: 'Lumi',
        showTitle: false,
        showCreateIcon: false,
        showSettingsIcon: true,
        hasMessages: messages.isNotEmpty,
        onSettingsPressed: () {
          Navigator.pushNamed(context, '/settings');
        },
        onCreatePressed: _resetConversation, // Passer la fonction de réinitialisation
      ),
      drawer: Drawer(
        backgroundColor: AppConstants.backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      prefixIcon: const Icon(Icons.search),
                      label: 'Rechercher',
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.create),
                    iconSize: 24,
                    onPressed: () {
                      print('Icône d\'édition cliquée');
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Lumi'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Chats'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Offre emploi YaMoJOBS'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Illustration lutte cancer sein'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Illustration vectorielle femme ...'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Ensemble de maladies chatbot'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Créer projet Flutter'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Salut et comment ça va'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Salut ça va'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.purple,
                child: Text(
                  userName?.substring(0, 1).toUpperCase() ?? 'U',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(userName ?? 'Utilisateur'),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: [
              Expanded(
                child: messages.isEmpty
                    ? _buildInitialScreen() // Afficher l'interface initiale
                    : MessageList(messages: messages),
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 350),
                child: PresentationAI(
                  onSubmitted: _handleMessageSubmitted,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}