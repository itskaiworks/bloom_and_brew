import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

// Temporarily stores the user's sign-up information for login validation
class TemporaryAuthStore {
  static String? fullName;
  static String? email;
  static String? password;
}

// Underlined, labelled text field styled to match the app theme.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.suffixIcon,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDark ? colors.oat : colors.latte,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(color: colors.latte, fontSize: 15),
          cursorColor: colors.gold,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: colors.oat.withValues(alpha: 0.5),
              fontSize: 13,
            ),
            isDense: true,
            contentPadding: const EdgeInsets.only(bottom: 10),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: colors.line),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colors.line),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colors.gold, width: 1.4),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
            ),
            errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 11),
            suffixIcon: suffixIcon,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
          ),
        ),
      ],
    );
  }
}

// Circular social-login icon button (Login screen only).
class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.espressoDark,
            border: Border.all(color: colors.line),
            boxShadow: [
              BoxShadow(
                color: colors.latte.withValues(alpha: 0.06),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 17, color: colors.gold),
        ),
      ),
    );
  }
}

// Circular sun/moon button that flips [themeModeNotifier].
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        // Changes the app between light and dark mode
        onTap: toggleTheme,
        customBorder: const CircleBorder(),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.espressoDark.withValues(alpha: 0.85),
            border: Border.all(color: colors.line),
          ),
          alignment: Alignment.center,
          child: Icon(
            isDark ? Icons.wb_sunny_outlined : Icons.nightlight_outlined,
            size: 18,
            color: colors.gold,
          ),
        ),
      ),
    );
  }
}
