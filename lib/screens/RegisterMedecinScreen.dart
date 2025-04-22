import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../viewModel/RegisterMedecinViewModel.dart';
import '../utils/constants.dart';
import '../widgets/CustomDropdownTextField.dart';
import '../widgets/CustomTextField.dart';
import '../widgets/CustomTitle.dart';
import '../widgets/CustumButton.dart';
import '../widgets/NavigationButton.dart';

class RegisterMedecinScreen extends StatefulWidget {
  const RegisterMedecinScreen({super.key});

  @override
  _RegisterMedecinScreenState createState() => _RegisterMedecinScreenState();
}

class _RegisterMedecinScreenState extends State<RegisterMedecinScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomController;
  late TextEditingController _prenomController;
  late TextEditingController _dateDeNaissanceController;
  late TextEditingController _telephoneController;
  late TextEditingController _villeController;
  late TextEditingController _lieuServiceController;
  late TextEditingController _specialiteController;
  late TextEditingController _numeroONMCController;
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
    _lieuServiceController = TextEditingController();
    _specialiteController = TextEditingController();
    _numeroONMCController = TextEditingController();
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
    _lieuServiceController.dispose();
    _specialiteController.dispose();
    _numeroONMCController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, RegisterMedecinViewModel viewModel) async {
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
    return Consumer<RegisterMedecinViewModel>(
      builder: (context, viewModel, child) {
        // Synchronisez les valeurs des contrôleurs avec le viewModel.medecin
        _nomController.text = viewModel.medecin.nom;
        _prenomController.text = viewModel.medecin.prenom;
        _dateDeNaissanceController.text = viewModel.medecin.dateDeNaissance;
        _telephoneController.text = viewModel.medecin.numeroTelephone;
        _villeController.text = viewModel.medecin.ville;
        _lieuServiceController.text = viewModel.medecin.lieuService;
        _specialiteController.text = viewModel.medecin.specialite;
        _numeroONMCController.text = viewModel.medecin.numeroONMC;
        _emailController.text = viewModel.medecin.email;
        _passwordController.text = viewModel.medecin.password;

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
                  viewModel.medecin.reset();
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
                    subtitle: 'Renseignez vos informations',
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

  Widget _buildStep(BuildContext context, RegisterMedecinViewModel viewModel) {
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
                if (viewModel.medecin.nomError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                    child: Text(
                      viewModel.medecin.nomError!,
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
                if (viewModel.medecin.prenomError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                    child: Text(
                      viewModel.medecin.prenomError!,
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
                      if (viewModel.medecin.dateDeNaissanceError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                          child: Text(
                            viewModel.medecin.dateDeNaissanceError!,
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
                        items: ['Homme', 'Femme'],
                        value: viewModel.medecin.sexe,
                        onChanged: (value) {
                          viewModel.setSexe(value);
                        },
                      ),
                      if (viewModel.medecin.sexeError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                          child: Text(
                            viewModel.medecin.sexeError!,
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
                  hintText: 'Le numéro de téléphone sera utile pour que le patient puisse vous joindre en cas de problème',
                  hintIcon: const Icon(Icons.info, size: 16, color: Colors.grey),
                ),
                if (viewModel.medecin.numeroTelephoneError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                    child: Text(
                      viewModel.medecin.numeroTelephoneError!,
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
                if (viewModel.medecin.villeError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                    child: Text(
                      viewModel.medecin.villeError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'Lieu de service',
                  controller: _lieuServiceController,
                  onChanged: (value) => viewModel.setLieuService(value),
                ),
                if (viewModel.medecin.lieuServiceError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                    child: Text(
                      viewModel.medecin.lieuServiceError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'Spécialité',
                  controller: _specialiteController,
                  onChanged: (value) => viewModel.setSpecialite(value),
                ),
                if (viewModel.medecin.specialiteError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                    child: Text(
                      viewModel.medecin.specialiteError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'Numéro ONMC',
                  controller: _numeroONMCController,
                  onChanged: (value) => viewModel.setNumeroONMC(value),
                ),
                if (viewModel.medecin.numeroONMCError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                    child: Text(
                      viewModel.medecin.numeroONMCError!,
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
                  label: 'Email',
                  controller: _emailController,
                  onChanged: (value) => viewModel.setEmail(value),
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: const Icon(Icons.email),
                  hintText: 'L\'email servira à vous connecter en toute sécurité',
                  hintIcon: const Icon(Icons.info, size: 16, color: Colors.grey),
                ),
                if (viewModel.medecin.emailError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                    child: Text(
                      viewModel.medecin.emailError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'Mot de passe',
                  controller: _passwordController,
                  onChanged: (value) => viewModel.setPassword(value),
                  obscureText: true,
                ),
                if (viewModel.medecin.passwordError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                    child: Text(
                      viewModel.medecin.passwordError!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),

            Column(
              children: [
                CheckboxListTile(
                  title: const Text('J\'accepte les conditions d\'utilisation'),
                  value: viewModel.medecin.accepteConditions,
                  onChanged: (value) {
                    viewModel.setAccepteConditions(value ?? false);
                  },
                  activeColor: AppConstants.primaryColor,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                ),
                CustomButton(
                  label: 'Soumettre',
                  color: AppConstants.primaryColor,
                  onPressed: !viewModel.medecin.accepteConditions || viewModel.isSubmitting
                      ? null
                      : () {
                    viewModel.registerMedecin(context);
                  },
                  child: viewModel.isSubmitting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : null,
                ),
              ], ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}