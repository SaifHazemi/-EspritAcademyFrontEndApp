import 'dart:ui'; // for ImageFilter (blur)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:espritacademy/theme/app_theme.dart';
import 'package:espritacademy/controllers/reset_password_controller.dart';

class ResetPasswordPage extends StatefulWidget {
  final String? token; // optionnel — peut être injecté via Deep Link / Email

  const ResetPasswordPage({Key? key, this.token}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _tokenCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  final _showPassword = false.obs;
  final _showConfirm = false.obs;

  // GetX Controller
  final ResetPasswordController _controller = Get.put(ResetPasswordController());

  @override
  void initState() {
    super.initState();
    if (widget.token != null && widget.token!.isNotEmpty) {
      _tokenCtrl.text = widget.token!;
    }
  }

  @override
  void dispose() {
    _tokenCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final token = _tokenCtrl.text.trim();
    final password = _passwordCtrl.text.trim();

    if (token.isEmpty) {
      Get.snackbar(
        "Erreur",
        "Le jeton de réinitialisation est requis.",
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    _controller.submit(token: token, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return _GlassBackground(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          _GlassCard(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Text(
                    'Réinitialiser le mot de passe',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Définissez un nouveau mot de passe sécurisé pour votre compte.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Illustration icône
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.25),
                          width: 1.2,
                        ),
                      ),
                      child: Icon(
                        Icons.lock_reset_rounded,
                        size: 64,
                        color: Colors.white.withOpacity(0.95),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Nouveau mot de passe
                  Obx(
                        () => TextFormField(
                      controller: _passwordCtrl,
                      style: const TextStyle(color: Colors.white),
                      obscureText: !_showPassword.value,
                      decoration: _glassInput(
                        label: 'Nouveau mot de passe',
                        icon: Icons.lock_outline,
                      ).copyWith(
                        hintText: 'Au moins 6 caractères',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.65),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showPassword.value ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white.withOpacity(0.95),
                          ),
                          onPressed: () => _showPassword.value = !_showPassword.value,
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Requis';
                        if (v.length < 6) return 'Min 6 caractères';
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Confirmation
                  Obx(
                        () => TextFormField(
                      controller: _confirmCtrl,
                      style: const TextStyle(color: Colors.white),
                      obscureText: !_showConfirm.value,
                      decoration: _glassInput(
                        label: 'Confirmer le mot de passe',
                        icon: Icons.lock_reset_outlined,
                      ).copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showConfirm.value ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white.withOpacity(0.95),
                          ),
                          onPressed: () => _showConfirm.value = !_showConfirm.value,
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Requis';
                        if (v != _passwordCtrl.text) {
                          return 'Les mots de passe ne correspondent pas';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Bouton gradient + spinner overlay si loading
                  Obx(
                        () => Stack(
                      alignment: Alignment.center,
                      children: [
                        _GradientButton(
                          label: "Réinitialiser",
                          onPressed: _controller.isLoading.value ? null : _handleSubmit,
                        ),
                        if (_controller.isLoading.value)
                          const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  /// ====== Helpers UI (identiques au LoginScreen) ======

  InputDecoration _glassInput({
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
      fillColor: Colors.white.withOpacity(0.12),
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
}

/// ====== Widgets utilitaires (privés) pour le design glass ======

class _GlassBackground extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;

  const _GlassBackground({
    Key? key,
    required this.child,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Stack(
        children: [
          // Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryColor.withOpacity(0.8),
                  AppTheme.secondaryColor.withOpacity(0.8),
                  AppTheme.backgroundColor,
                ],
                stops: const [0.0, 0.45, 1.0],
              ),
            ),
          ),
          // Cercles floutés
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
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _blurCircle({required double size, required Color color}) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [color, Colors.transparent],
              stops: const [0.3, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double blur;

  const _GlassCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(22, 28, 22, 22),
    this.borderRadius = 26,
    this.blur = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: double.infinity,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
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
          child: child,
        ),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double height;
  final double borderRadius;

  const _GradientButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.height = 56,
    this.borderRadius = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 8,
          shadowColor: AppTheme.primaryColor.withOpacity(0.5),
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: enabled
                  ? [AppTheme.primaryColor, AppTheme.secondaryColor]
                  : [
                AppTheme.primaryColor.withOpacity(0.5),
                AppTheme.secondaryColor.withOpacity(0.5)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Center(
            child: Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
