import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../viewModel/LoginViewModel.dart';
import '../widgets/CreationAccountSection.dart';
import '../widgets/CustomTitle.dart';
import '../widgets/CustomTextField.dart';
import '../widgets/CustumButton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const CustomTitle(
                    title: 'Connectez-vous',
                    subtitle: 'Renseignez votre email et mot de passe',
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              label: 'Email',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              suffixIcon: const Icon(Icons.email),
                              onChanged: (value) {
                                viewModel.setEmail(value);
                              },
                            ),
                            if (viewModel.emailError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                                child: Text(
                                  viewModel.emailError!,
                                  style: const TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              label: 'Mot de passe',
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              onChanged: (value) {
                                viewModel.setPassword(value);
                              },
                            ),
                            if (viewModel.passwordError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                                child: Text(
                                  viewModel.passwordError!,
                                  style: const TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.pushNamed(context, '/forgot_password');
                                },
                                child: Text(
                                  'Mot de passe oublié?',
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontSize: AppConstants.hintTextSize,
                                    color: AppConstants.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          label: 'Connexion',
                          color: AppConstants.primaryColor,
                          onPressed: viewModel.isSubmitting || viewModel.emailError != null || viewModel.passwordError != null
                              ? null
                              : () {
                            viewModel.login(context);
                          },
                          child: viewModel.isSubmitting
                              ? const CircularProgressIndicator(color: Colors.white)
                              : null,
                        ),
                        const SizedBox(height: 16),
                        const CreateAccountSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}