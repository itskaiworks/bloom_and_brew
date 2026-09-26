import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Used to validate all fields inside the login form
  final _formKey = GlobalKey<FormState>();

  // Controllers store the values entered by the user
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();

  // Controls whether the password is hidden or visible
  bool _obscurePassword = true;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Validates the form and checks the entered credentials
  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      final email = _identifierController.text.trim();
      final password = _passwordController.text;

      // Validate credentials against temporary Sign-Up credentials
      if (TemporaryAuthStore.email == email &&
          TemporaryAuthStore.password == password &&
          TemporaryAuthStore.email != null) {
        // Navigate to Home and pass the user's name as an argument.
        Navigator.pushReplacementNamed(
          context,
          '/home',
          arguments: TemporaryAuthStore.fullName,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final serifDisplay = GoogleFonts.dmSerifDisplay(color: colors.latte);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colors.espresso,
      body: Center(
        child: Container(
          height: 1000,
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            colors.latte.withValues(alpha: 0.05),
                            colors.espresso.withValues(alpha: 0.55),
                            colors.espresso,
                          ],
                          stops: const [0.0, 0.75, 1.0],
                        ),
                      ),
                    ),
                    SafeArea(
                      bottom: false,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12, right: 12),
                          child: ThemeToggleButton(isDark: isDark),
                        ),
                      ),
                    ),
                    SafeArea(
                      bottom: false,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.coffee_rounded,
                                size: 34,
                                color: colors.gold,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Bloom & Brew',
                                style: serifDisplay.copyWith(fontSize: 24),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Roasted daily, poured with care',
                                style: TextStyle(
                                  color: colors.oat,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SafeArea(
                  top: false,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 24,
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 380),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ready for another sip?',
                                style: serifDisplay.copyWith(fontSize: 22),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Sign in to order your usual',
                                style: TextStyle(
                                  color: colors.oat,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 32),

                              AppTextField(
                                label: 'Email or Username',
                                hint: 'you@example.com or @username',
                                controller: _identifierController,
                                keyboardType: TextInputType.emailAddress,

                                // Checks if the email/username is valid and matches the signed-up account
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Enter your email or username';
                                  }

                                  if (!value.contains('@')) {
                                    return 'Please enter a valid username or email address.';
                                  }

                                  // Checks if there is no signed-up account yet
                                  if (TemporaryAuthStore.email == null) {
                                    return 'Account does not exist. Please sign up first.';
                                  }

                                  // Checks if the entered email is incorrect
                                  if (value.trim() !=
                                      TemporaryAuthStore.email) {
                                    return 'Incorrect email.';
                                  }

                                  return null;
                                },
                              ),
                              const SizedBox(height: 22),

                              AppTextField(
                                label: 'Password',
                                hint: '••••••',
                                controller: _passwordController,
                                obscureText: _obscurePassword,

                                // Checks if the password meets the required length and matches the account
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter your password';
                                  }

                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters.';
                                  }

                                  // Checks if there is no signed-up account yet
                                  if (TemporaryAuthStore.password == null) {
                                    return '';
                                  }

                                  // Checks if the entered password is incorrect
                                  if (value != TemporaryAuthStore.password) {
                                    return 'Incorrect password.';
                                  }

                                  return null;
                                },

                                // Button for showing or hiding the password
                                suffixIcon: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(
                                    minWidth: 24,
                                    minHeight: 24,
                                  ),
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: colors.oat,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(
                                      () =>
                                          _obscurePassword = !_obscurePassword,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 12),

                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(0, 0),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                      color: colors.oat,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 28),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _handleLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colors.cinnamon,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Log in',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 28),

                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: colors.line,
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Text(
                                      'or',
                                      style: TextStyle(
                                        color: colors.oat.withValues(
                                          alpha: 0.8,
                                        ),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: colors.line,
                                      thickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SocialLoginButton(
                                    icon: Icons.email_rounded,
                                    onTap: () {},
                                  ),
                                  const SizedBox(width: 18),
                                  SocialLoginButton(
                                    icon: Icons.facebook_rounded,
                                    onTap: () {},
                                  ),
                                  const SizedBox(width: 18),
                                  SocialLoginButton(
                                    icon: Icons.tiktok_rounded,
                                    onTap: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(height: 28),

                              Center(
                                child: GestureDetector(
                                  onTap: () =>
                                      Navigator.pushNamed(context, '/signup'),
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: colors.oat,
                                        fontSize: 13,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: 'New to Bloom & Brew? ',
                                        ),
                                        TextSpan(
                                          text: 'Create an account',
                                          style: TextStyle(
                                            color: colors.gold,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}
