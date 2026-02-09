import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:espritacademy/controllers/login_controller.dart';
import 'package:espritacademy/screeens/forget_password.dart';
import 'package:espritacademy/screeens/signup_screen.dart';
import 'package:espritacademy/theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LoginController login = Get.put(LoginController());
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final niveauController = TextEditingController(); // Keeping this as it was in original
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor, // Changed background color
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.secondaryColor.withOpacity(0.05), // Softer primary color
                AppTheme.backgroundColor,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    // Header
                    Text(
                      "Bon retour!",
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: AppTheme.primaryColor, // Header color remains
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Nous sommes si heureux de vous revoir!",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary, // Changed to secondary text color
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 40),
                    // Image
                    SizedBox(
                      height: 200,
                      child: Image.asset("assets/images/boy.png"),
                    ),

                    const SizedBox(height: 40),

                    // Email Field
                    TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir votre adresse e-mail';
                        } else if (!GetUtils.isEmail(value)) {
                          return 'Veuillez saisir une adresse e-mail valide';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Adresse Email",
                        labelStyle: TextStyle(color: AppTheme.textSecondary), // Text color for label
                        prefixIcon: Icon(Icons.email_outlined, color: AppTheme.primaryColor), // Changed icon color
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Password Field
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez saisir votre mot de passe';
                        }
                        if (value.length < 6) {
                          return 'Le mot de passe doit contenir au moins 6 caractères';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Mot de passe",
                        labelStyle: TextStyle(color: AppTheme.textSecondary), // Text color for label
                        prefixIcon: Icon(Icons.lock_outline, color: AppTheme.primaryColor), // Changed icon color
                      ),
                    ),

                    const SizedBox(height: 12),
                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Get.to(() => ForgetPasswordPage()),
                        child: const Text("Mot de passe oublié?", style: TextStyle(color: AppTheme.primaryColor)), // Button text color
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Login Button
                    SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            login.signin(
                              usernameController.text,
                              passwordController.text,
                              niveauController.text,
                            );
                          }
                        },
                        child: const Text("CONNEXION"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor, // Changed button background color
                          foregroundColor: Colors.white, // Text color for button
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey[300])),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text("OU", style: TextStyle(color: AppTheme.textSecondary)), // Changed text color
                        ),
                        Expanded(child: Divider(color: Colors.grey[300])),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Signup Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Pas encore membre?", style: TextStyle(color: AppTheme.textSecondary)), // Changed text color
                        TextButton(
                          onPressed: () => Get.to(() => SignupScreen()),
                          child: const Text(
                            "Inscrivez-vous",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor, // Button text color
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}