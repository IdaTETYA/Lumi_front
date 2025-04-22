import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lumi_frontend/viewModel/RegisterPatientViewModel.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../widgets/CustomDropdownTextField.dart';
import '../widgets/CustomTextField.dart';
import '../widgets/CustomTitle.dart';
import '../widgets/CustumButton.dart';
import '../widgets/NavigationButton.dart';

class RegisterPatientScreen extends StatefulWidget {
  const RegisterPatientScreen({super.key});

  @override
  _RegisterPatientScreenState createState() => _RegisterPatientScreenState();
}

class _RegisterPatientScreenState extends State<RegisterPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomController;
  late TextEditingController _prenomController;
  late TextEditingController _dateDeNaissanceController;
  late TextEditingController _telephoneController;
  late TextEditingController _villeController;
  late TextEditingController _quartierController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    // Initialisez les contrôleurs
    _nomController = TextEditingController();
    _prenomController = TextEditingController();
    _dateDeNaissanceController = TextEditingController();
    _telephoneController = TextEditingController();
    _villeController = TextEditingController();
    _quartierController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // Libérez les contrôleurs
    _nomController.dispose();
    _prenomController.dispose();
    _dateDeNaissanceController.dispose();
    _telephoneController.dispose();
    _villeController.dispose();
    _quartierController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, RegisterPatientViewModel viewModel) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      viewModel.setDateDeNaissance(formattedDate);
      _dateDeNaissanceController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterPatientViewModel>(
      builder: (context, viewModel, child) {
        // Synchronisez les valeurs des contrôleurs avec le viewModel.patient
        _nomController.text = viewModel.patient.nom;
        _prenomController.text = viewModel.patient.prenom;
        _dateDeNaissanceController.text = viewModel.patient.dateDeNaissance;
        _telephoneController.text = viewModel.patient.numeroTelephone;
        _villeController.text = viewModel.patient.ville;
        _quartierController.text = viewModel.patient.quartier;
        _emailController.text = viewModel.patient.email;
        _passwordController.text = viewModel.patient.password;

        return Scaffold(
          appBar: AppBar(
            title: Text('Création de Compte ${viewModel.currentStep}/3'),
            backgroundColor: AppConstants.backgroundColor,
            titleTextStyle: const TextStyle(
              fontSize: AppConstants.buttonTextSize,
              color: Colors.black,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  viewModel.patient.reset();
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const CustomTitle(
                    title: 'Création de compte',
                    subtitle: 'Renseignez votre identité',
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: _buildStep(context, viewModel),
                  ),
                  NavigationButtons(
                    onPreviousPressed: viewModel.currentStep > 1
                        ? () {
                      viewModel.goToPreviousStep();
                    }
                        : null,
                    onNextPressed: viewModel.currentStep < 3
                        ? () {
                      viewModel.canGoToNextStep(viewModel.currentStep, _formKey);
                    }
                        : null,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStep(BuildContext context, RegisterPatientViewModel viewModel) {
    switch (viewModel.currentStep) {
      case 1:
        return ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'Nom',
                  controller: _nomController,
                  onChanged: (value) => viewModel.setNom(value),
                  suffixIcon: const Icon(Icons.person),
                ),
                if (viewModel.patient.nomError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                    child: Text(
                      viewModel.patient.nomError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'Prénom',
                  controller: _prenomController,
                  onChanged: (value) => viewModel.setPrenom(value),
                  suffixIcon: const Icon(Icons.person),
                ),
                if (viewModel.patient.prenomError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                    child: Text(
                      viewModel.patient.prenomError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: 'Date de naissance',
                        controller: _dateDeNaissanceController,
                        readOnly: true,
                        onTap: () => _selectDate(context, viewModel),
                        suffixIcon: const Icon(Icons.calendar_month),
                      ),
                      if (viewModel.patient.dateDeNaissanceError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                          child: Text(
                            viewModel.patient.dateDeNaissanceError!,
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomDropdownField(
                        label: 'Sexe',
                        items: ['Féminin', 'Masculin'],
                        value: viewModel.patient.sexe,
                        onChanged: (value) {
                          viewModel.setSexe(value);
                        },
                      ),
                      if (viewModel.patient.sexeError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                          child: Text(
                            viewModel.patient.sexeError!,
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'Téléphone',
                  controller: _telephoneController,
                  onChanged: (value) => viewModel.setNumeroTelephone(value),
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('🇨🇲', style: TextStyle(fontSize: 20)),
                        SizedBox(width: 4),
                        Text('+237'),
                      ],
                    ),
                  ),
                  hintText:
                  'Le numéro de téléphone sera utile pour que le professionnel de santé puisse vous joindre en cas de problème',
                  hintIcon: const Icon(Icons.info, size: 16, color: Colors.grey),
                ),
                if (viewModel.patient.numeroTelephoneError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                    child: Text(
                      viewModel.patient.numeroTelephoneError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ],
        );
      case 2:
        return ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'Ville',
                  controller: _villeController,
                  onChanged: (value) => viewModel.setVille(value),
                ),
                if (viewModel.patient.villeError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                    child: Text(
                      viewModel.patient.villeError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'Quartier',
                  controller: _quartierController,
                  onChanged: (value) => viewModel.setQuartier(value),
                ),
                if (viewModel.patient.quartierError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                    child: Text(
                      viewModel.patient.quartierError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
            CheckboxListTile(
              title: const Text('Avez-vous des antécédents dans votre famille ?'),
              value: viewModel.patient.hasFamilyHistory,
              onChanged: (bool? value) {
                viewModel.setHasFamilyHistory(value ?? false);
              },
              activeColor: AppConstants.primaryColor,
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'Email',
                  controller: _emailController,
                  onChanged: (value) => viewModel.setEmail(value),
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: const Icon(Icons.email),
                  hintText: 'L\'email servira à vous connecter en toute sécurité',
                  hintIcon: const Icon(Icons.info, size: 16, color: Colors.grey),
                ),
                if (viewModel.patient.emailError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                    child: Text(
                      viewModel.patient.emailError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ],
        );
      case 3:
        return ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'Mot de passe',
                  controller: _passwordController,
                  onChanged: (value) => viewModel.setPassword(value),
                  obscureText: true,
                ),
                if (viewModel.patient.passwordError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                    child: Text(
                      viewModel.patient.passwordError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
            CheckboxListTile(
              title: const Text('J\'accepte les conditions d\'utilisation'),
              value: viewModel.patient.accepteConditions,
              onChanged: (value) {
                viewModel.setAccepteConditions(value ?? false);
              },
              activeColor: AppConstants.primaryColor,
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
            ),
            CustomButton(
              label: 'Soumettre',
              color: AppConstants.primaryColor,
              onPressed: !viewModel.patient.accepteConditions || viewModel.isSubmitting
                  ? null
                  : () {
                viewModel.registerPatient(context);
              },
              child: viewModel.isSubmitting
                  ? const CircularProgressIndicator(color: Colors.white)
                  : null,
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}