import 'package:flutter/material.dart';
import 'package:lumi_frontend/utils/constants.dart';

import '../utils/cerclewidget.dart';
import '../widgets/CustumButton.dart';

class ChoixTypeCompteScreen extends StatelessWidget {
  const ChoixTypeCompteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fond blanc
          Container(
            color: Colors.white,
          ),
          Positioned(
            bottom: 0,
            left: 2.0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width * 0.9, 500),
                painter: WavePainter()
            ),
          ),
          // Contenu principal
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // En-tête avec logo et icône de recherche
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1), // Fond léger pour le cercle
                      ),
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return RadialGradient(
                            center: Alignment.center,
                            radius: 1.0,
                            colors: [
                              AppConstants.primaryColor,
                              AppConstants.secondColor,
                              AppConstants.secondColor,
                            ],
                            tileMode: TileMode.clamp,
                          ).createShader(bounds);
                        },
                        child: Text(
                          'Lumi',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    ],
                  ),
                  SizedBox(height: 10),
                  // Titre principal
                  Text(
                    'Choisissez votre type de compte',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 24),
                  // Liste de points clés
                  _buildCheckListItem('Discutez avec une Ia'),
                  _buildCheckListItem('Consulter des professionels'),
                  _buildCheckListItem('Lisez des articles '),
                  _buildCheckListItem('recevez des conseils '),
                  SizedBox(height: 16),
                  SizedBox(height: 24),
                  // Liste de spécialités

                  // Boutons
                  Center(
                    child: Column(
                      children: [
                        CustomButton(
                          label: 'Compte Patient',
                          color: AppConstants.primaryColor,
                          onPressed: (){
                            Navigator.pushNamed(context, '/registerPatient');
                          },
                        ),
                        SizedBox(height: 16),

                        CustomButton(
                          label: 'Compte Medecin',
                          color: AppConstants.primaryColor,
                          onPressed: ()
                          {
                            Navigator.pushNamed(context, '/registerMedecin');
                          },
                        ),
                        SizedBox(height: 30),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            'Se connecter',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckListItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: Colors.black54, // Turquoise
            size: 20,

          ),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

