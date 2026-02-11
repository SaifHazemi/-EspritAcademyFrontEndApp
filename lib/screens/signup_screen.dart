import 'dart:io';
import 'dart:ui';
import 'package:espritacademy/controllers/register_controller.dart';
import 'package:espritacademy/theme/app_theme.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final RegisterController registerController = Get.put(RegisterController());

  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  // Controllers
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final niveauController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      registerController.register(
        _image,
        emailController.text,
        lastnameController.text,
        firstnameController.text,
        passwordController.text,
        niveauController.text,
      );
    }
  }

  ImageProvider? _getImageProvider() {
    if (_image == null) return null;
    if (kIsWeb) {
      return NetworkImage(_image!.path); // Blob URL on web
    } else {
      return FileImage(File(_image!.path)); // File path on mobile
    }
  }

  // ——— UI uniquement : décorateur d’inputs glass
  InputDecoration _glassInput(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
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

      // AppBar : visuel uniquement (retour)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),

      body: Stack(
        children: [
          // 🟦 Fond en UNE seule couleur
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
          // Contenu principal dans une "glass card"
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
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

                      // Form : même logique, nouveau look
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 6),
                            Text(
                              "Créer un compte",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Rejoignez‑nous pour commencer votre apprentissage !",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 22),

                            // Sélecteur d’image – avatar en style glass
                            Center(
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.6),
                                      width: 2,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor:
                                    Colors.white.withOpacity(0.10),
                                    backgroundImage: _getImageProvider(),
                                    child: _image == null
                                        ? Icon(
                                      Icons.camera_alt,
                                      size: 34,
                                      color: Colors.white.withOpacity(0.95),
                                    )
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Text(
                                "Ajouter une photo de profil",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Inputs — même validation, nouveau style
                            TextFormField(
                              controller: firstnameController,
                              validator: (value) =>
                              (value == null || value.isEmpty)
                                  ? 'Requit'
                                  : null,
                              style: const TextStyle(color: Colors.white),
                              decoration:
                              _glassInput("Prénom", Icons.person_outline),
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: lastnameController,
                              validator: (val) => val!.isEmpty ? 'Requit' : null,
                              style: const TextStyle(color: Colors.white),
                              decoration:
                              _glassInput("Nom", Icons.badge_outlined),
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Requit';
                                }
                                if (!GetUtils.isEmail(value)) {
                                  return 'Email invalide';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.white),
                              decoration:
                              _glassInput("Email", Icons.email_outlined),
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Requit';
                                }
                                if (value.length < 6) {
                                  return 'Min 6 caractères';
                                }
                                return null;
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: _glassInput(
                                  "Mot de passe", Icons.lock_outline),
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: niveauController,
                              validator: (val) => val!.isEmpty ? 'Requit' : null,
                              style: const TextStyle(color: Colors.white),
                              decoration:
                              _glassInput("Niveau", Icons.school_outlined),
                            ),

                            const SizedBox(height: 28),

                            // Bouton — même action, style gradient
                            SizedBox(
                              height: 56,
                              child: ElevatedButton(
                                onPressed: _handleSignup,
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 6,
                                  shadowColor:
                                  Colors.white.withOpacity(0.4),
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
                                      "S'INSCRIRE",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Lien — inchangé côté logique
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Déjà membre?",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.85),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text(
                                    "Connectez‑vous",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 6),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}