import 'package:espritacademy/screeens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:espritacademy/services/auth_service.dart';

class ForgotPasswordController extends GetxController {
  AuthService authService = AuthService();

  Future<void> sendResetEmail(String email) async {
    try {
      await authService.forgotPassword(email);

      Get.snackbar(
        "E-mail envoyé",
        "Les instructions ont été envoyées à $email",
      );

      // 🔥 Go back after 1 second
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.off(LoginScreen());;  // return to previous page (usually login)
      });

    } catch (e) {
      Get.snackbar(
        "Erreur",
        "Impossible d'envoyer l'e-mail: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }
}