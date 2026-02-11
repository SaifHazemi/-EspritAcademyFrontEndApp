import 'dart:ui';
import 'package:espritacademy/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import your controller
import 'package:espritacademy/controllers/forgot_password_controller.dart';

class ForgetPasswordPage extends StatelessWidget {
  // ✅ Keep your exact controllers
  final TextEditingController _emailController = TextEditingController();
  final ForgotPasswordController forgotPasswordController =
  Get.put(ForgotPasswordController()); // SAME AS SIGNUP

  ForgetPasswordPage({Key? key}) : super(key: key);

  // ✅ Keep your exact logic (unchanged)
  void _handleForgotPassword() {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        "Erreur",
        "Veuillez entrer une adresse e-mail",
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    print("TEST");
    forgotPasswordController.sendResetEmail(email); // SAME LOGIC AS SIGNUP CALLS
  }

  // 🎨 UI-only: shared input decoration (glass style)
  InputDecoration _glassInput({
    required String label,
    String? hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.75)),
      prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.95)),
      filled: true,
      fillColor: Colors.white.withOpacity(0.12),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.25)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.25)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.7),
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      // Visual-only AppBar, logic unchanged
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // If you prefer white back icon, change to Colors.white
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),

      // 🎨 Design only: single-color background + glass card
      body: Stack(
        children: [
          // Single color background
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
          SafeArea(
            child: SingleChildScrollView(
              padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Glass card
                  ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.25),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.18),
                              blurRadius: 24,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Icon
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.18),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.35),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.lock_reset,
                                  size: 68,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            const SizedBox(height: 26),

                            // Title & subtitle
                            const Text(
                              'Mot de passe oublié ?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Entrez votre adresse e-mail pour recevoir les instructions de réinitialisation.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 15.5,
                                height: 1.35,
                              ),
                            ),

                            const SizedBox(height: 26),

                            // ✅ Email Input — same controller
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.white),
                              decoration: _glassInput(
                                label: 'Adresse e-mail',
                                hint: 'exemple@gmail.com',
                                icon: Icons.email_outlined,
                              ),
                            ),

                            const SizedBox(height: 26),

                            // ✅ Button — keep EXACT same click logic
                            SizedBox(
                              height: 56,
                              child: ElevatedButton(
                                onPressed: _handleForgotPassword, // ← unchanged
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 6,
                                  shadowColor: Colors.white.withOpacity(0.4),
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
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
                                  child: const Center(
                                    child: Text(
                                      'Envoyer',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}