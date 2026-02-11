import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';
import 'package:espritacademy/screeens/login_screen.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          children: [
            buildPage(
              imagePath: "assets/images/onboarding1.jpg",
              title: "Trouvez les meilleurs",
              subTitle: "cours avec nous",
              description: [
                "L’apprentissage peut être simple.",
                "Découvrez des cours adaptés à votre rythme.",
                "Alors… Qu’aimeriez-vous apprendre aujourd’hui ?",
              ],
              currentPage: 0,
              pageCount: 3,
              onTap: () => Get.to(() => LoginScreen()),
              buttonColor: Colors.blue,
            ),

            buildPage(
              imagePath: "assets/images/onboarding2.jpg",
              title: "Progressez à votre",
              subTitle: "propre rythme",
              description: [
                "Apprenez quand vous voulez.",
                "Des cours clairs, riches et interactifs.",
                "Votre réussite commence maintenant.",
              ],
              currentPage: 1,
              pageCount: 3,
              onTap: () => Get.to(() => LoginScreen()),
              buttonColor: Colors.blue,
            ),

            buildPage(
              imagePath: "assets/images/onboarding3.png",
              title: "Rejoignez notre",
              subTitle: "communauté d’apprenants",
              description: [
                "Des centaines d’étudiants motivés.",
                "Des parcours complets pour tous les niveaux.",
                "Êtes-vous prêt à commencer ?",
              ],
              currentPage: 2,
              pageCount: 3,
              onTap: () => Get.to(() => LoginScreen()),
              buttonColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPage({
    required String imagePath,
    required String title,
    required String subTitle,
    required List<String> description,
    required int currentPage,
    required int pageCount,
    required VoidCallback onTap,
    required Color buttonColor,
  }) {
    return Stack(
      children: [
        // Background gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.indigo.shade600,
                Colors.blue.shade400,
                Colors.white,
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // IMAGE
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // TEXT CONTAINER GLASSMORPHISM
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '$title ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: subTitle,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  color: Colors.yellowAccent,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: description
                              .map(
                                (line) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text(
                                line,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // BUTTON
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 52,
                  width: 180,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        buttonColor.withOpacity(0.9),
                        buttonColor.withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: buttonColor.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Continuer",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // DOTS INDICATOR
              DotsIndicator(
                dotsCount: pageCount,
                position: currentPage,
                decorator: DotsDecorator(
                  size: const Size(8, 8),
                  activeSize: const Size(22, 8),
                  activeColor: Colors.white,
                  color: Colors.white.withOpacity(0.4),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}