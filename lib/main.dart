// lib/main.dart
import 'package:flutter/material.dart';
import 'package:lumi_frontend/screens/ChatAIScreen.dart';
import 'package:lumi_frontend/screens/ChoixTypeCompteScreen.dart';
import 'package:lumi_frontend/screens/RegisterMedecinScreen.dart';
import 'package:lumi_frontend/viewModel/LoginViewModel.dart';
import 'package:lumi_frontend/viewModel/RegisterMedecinViewModel.dart';
import 'package:provider/provider.dart';
import 'viewModel/RegisterPatientViewModel.dart';
import 'screens/RegisterPatientScreen.dart';
import 'screens/LoginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterPatientViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterMedecinViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: MaterialApp(
        title: 'Mon Application',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/registerPatient': (context) => const RegisterPatientScreen(),
          '/registerMedecin': (context) => const RegisterMedecinScreen(),
          '/login': (context) => const LoginScreen(), // À implémenter
          '/typeCompte': (context) => const ChoixTypeCompteScreen(), // À implémenter
          '/lumi': (context) => const ChatAIScreen(), // À implémenter
        },
      ),
    );
  }
}