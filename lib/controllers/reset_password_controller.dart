import 'package:espritacademy/screeens/login_screen.dart';
import 'package:get/get.dart';
import 'package:espritacademy/services/auth_service.dart';

class ResetPasswordController extends GetxController {
  final AuthService _authService = AuthService();

  final isLoading = false.obs;

  Future<void> submit({
    required String token,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      await _authService.resetPassword(token: token, newPassword: password);

      Get.snackbar(
        "Succès",
        "Mot de passe réinitialisé. Veuillez vous connecter.",
        snackPosition: SnackPosition.BOTTOM,
      );

      // Go back to login (or previous screen)
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAll(() => LoginScreen());
      });
    } catch (e) {
      Get.snackbar(
        "Erreur",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}