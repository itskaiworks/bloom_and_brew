import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Used to validate all fields inside the sign-up form
  final _formKey = GlobalKey<FormState>();

  // Controllers store the values entered by the user
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Controls whether each password field is hidden or visible
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Validates the form and temporarily stores the account information
  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      // Used to store full name, email, and password temporarily
      TemporaryAuthStore.fullName = _fullNameController.text.trim();
      TemporaryAuthStore.email = _emailController.text.trim();
      TemporaryAuthStore.password = _passwordController.text;

      // Replace the stack so Back from Home doesn't return to Sign Up.
      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: TemporaryAuthStore.fullName,
      );
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
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.28,
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
                            colors.latte.withOpacity(0.05),
                            colors.espresso.withOpacity(0.55),
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
                          padding: const EdgeInsets.only(bottom: 10),
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
                                'Create an account',
                                style: serifDisplay.copyWith(fontSize: 22),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Join us for your daily brew',
                                style: TextStyle(
                                  color: colors.oat,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 32),

                              AppTextField(
                                label: 'Full name',
                                hint: 'Jane Doe',
                                controller: _fullNameController,
                                keyboardType: TextInputType.name,

                                // Checks that the name of the user is not empty
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Enter your full name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 22),

                              AppTextField(
                                label: 'Email or Username',
                                hint: 'you@example.com or @username',
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,

                                // Checks that the email/username is not empty and contains '@'
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Enter your email or username';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Please enter a valid username or email address.';
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

                                // Checks that the password is entered and has at least 6 characters
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter a password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters.';
                                  }
                                  return null;
                                },
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
                              const SizedBox(height: 22),

                              AppTextField(
                                label: 'Confirm password',
                                hint: '••••••',
                                controller: _confirmPasswordController,
                                obscureText: _obscureConfirmPassword,

                                // Checks that the confirmation matches the original password
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Confirm your password';
                                  }
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                suffixIcon: IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(
                                    minWidth: 24,
                                    minHeight: 24,
                                  ),
                                  icon: Icon(
                                    _obscureConfirmPassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: colors.oat,
                                    size: 20,
                                  ),

                                  // Toggles confirmation password visibility
                                  onPressed: () {
                                    setState(
                                      () => _obscureConfirmPassword =
                                          !_obscureConfirmPassword,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 28),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _handleSignUp,
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
                                    'Sign up',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 28),

                              Center(
                                child: GestureDetector(
                                  onTap: () =>
                                      Navigator.pushNamed(context, '/'),
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: colors.oat,
                                        fontSize: 13,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: 'Already have an account? ',
                                        ),
                                        TextSpan(
                                          text: 'Log in',
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
