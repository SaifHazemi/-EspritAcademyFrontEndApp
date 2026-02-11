import 'dart:ui'; // <-- for ImageFilter (blur)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:espritacademy/controllers/login_controller.dart';
import 'package:espritacademy/screeens/forget_password.dart';
import 'package:espritacademy/screeens/signup_screen.dart';
import 'package:espritacademy/theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController login = Get.put(LoginController());
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final niveauController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  InputDecoration glassInput({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.85),
      ),
      prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.95)),
      filled: true,
      // translucent white fill
      fillColor: Colors.white.withOpacity(0.12),
      // rounded, subtle borders
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.25),
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.55),
          width: 1.4,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: Colors.redAccent.withOpacity(0.8)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: Colors.redAccent.withOpacity(0.9)),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // keep your theme background if needed
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryColor.withOpacity(0.5),
                  AppTheme.secondaryColor.withOpacity(0.8),
                  AppTheme.backgroundColor,
                ],
                stops: const [0.0, 0.45, 1.0],
              ),
            ),
          ),

          // Decorative circles for depth
          Positioned(
            top: -60,
            left: -40,
            child: _blurCircle(
              size: 220,
              color: Colors.white.withOpacity(0.08),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -30,
            child: _blurCircle(
              size: 280,
              color: Colors.white.withOpacity(0.06),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    // Glass card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(22, 28, 22, 22),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            color: Colors.white.withOpacity(0.14),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.25),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 24,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Header
                                Text(
                                  "Bon retour!",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.displayMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "Nous sommes si heureux de vous revoir!",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white.withOpacity(0.85),
                                  ),
                                ),

                                const SizedBox(height: 22),

                                // Illustration
                                SizedBox(
                                  height: 160,
                                  child: Image.asset(
                                    "assets/images/login.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),

                                const SizedBox(height: 22),

                                // Email
                                TextFormField(
                                  controller: usernameController,
                                  style: const TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir votre adresse e-mail';
                                    } else if (!GetUtils.isEmail(value)) {
                                      return 'Veuillez saisir une adresse e-mail valide';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: glassInput(
                                    label: "Adresse Email",
                                    icon: Icons.email_outlined,
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Password
                                TextFormField(
                                  controller: passwordController,
                                  style: const TextStyle(color: Colors.white),
                                  obscureText: _obscure,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir votre mot de passe';
                                    }
                                    if (value.length < 6) {
                                      return 'Le mot de passe doit contenir au moins 6 caractères';
                                    }
                                    return null;
                                  },
                                  decoration: glassInput(
                                    label: "Mot de passe",
                                    icon: Icons.lock_outline,
                                  ).copyWith(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.white.withOpacity(0.95),
                                      ),
                                      onPressed: () {
                                        setState(() => _obscure = !_obscure);
                                      },
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Forgot password
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () =>
                                        Get.to(() => ForgetPasswordPage()),
                                    child: Text(
                                      "Mot de passe oublié?",
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.95),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // Login button
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
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      elevation: 8,
                                      shadowColor:
                                      AppTheme.primaryColor.withOpacity(0.5),
                                    ),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppTheme.primaryColor,
                                            AppTheme.secondaryColor,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Center(
                                        child: const Text(
                                          "CONNEXION",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.5,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 18),

                                // Divider
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: Colors.white.withOpacity(0.25),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Text(
                                        "OU",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.85),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: Colors.white.withOpacity(0.25),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),

                                // Signup
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Pas encore membre?",
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.85),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Get.to(() => SignupScreen()),
                                      child: Text(
                                        "Inscrivez-vous",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Decorative blurred circle
  Widget _blurCircle({required double size, required Color color}) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color,
                Colors.transparent,
              ],
              stops: const [0.3, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}