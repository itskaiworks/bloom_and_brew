import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Name passed via Navigator arguments from SignUpScreen (a String)
    final args = ModalRoute.of(context)?.settings.arguments;
    final userName = (args is String && args.trim().isNotEmpty)
        ? args.trim()
        : 'Friend';

    return Scaffold(
      backgroundColor: colors.espresso,
      body: Center(
        child: Container(
          height: 1000,
          width: 490,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Scaffold(
            backgroundColor: colors.espresso,
            appBar: AppBar(
              backgroundColor: colors.espresso,
              elevation: 2,
              shadowColor: Colors.black.withOpacity(0.15),
              automaticallyImplyLeading: false,
              title: Text(
                'Bloom & Brew',
                style: GoogleFonts.dmSerifDisplay(
                  fontSize: 20,
                  color: colors.latte,
                ),
              ),

              // Toggles between light and dark mode
              actions: [
                IconButton(
                  icon: Icon(
                    isDark
                        ? Icons.wb_sunny_outlined
                        : Icons.nightlight_outlined,
                    color: colors.gold,
                  ),
                  onPressed: toggleTheme,
                ),
                const SizedBox(width: 8),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Container(color: colors.line, height: 1),
              ),
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                // Full-bleed background photo (fills the body, below the navbar)
                Image.asset(
                  'assets/images/home_background.jpg',
                  fit: BoxFit.cover,
                ),

                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        colors.espresso,
                        colors.espresso.withOpacity(0.0),
                        colors.espresso.withOpacity(0.0),
                        colors.espresso,
                      ],
                      stops: const [0.0, 0.18, 0.4, 0.68],
                    ),
                  ),
                ),

                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.only(
                          top: 300,
                          left: 20,
                          right: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Brewginnings, $userName!',
                              style: GoogleFonts.dmSerifDisplay(
                                fontSize: 30,
                                color: Colors.white,
                                shadows: const [
                                  Shadow(color: Colors.black45, blurRadius: 8),
                                ],
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'Your next favorite cup is just a tap away. Brew something wonderful, savor every sip, and let the moment bloom.',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                shadows: [
                                  Shadow(color: Colors.black45, blurRadius: 6),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(28, 0, 28, 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: colors.espressoDark,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: colors.line),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.local_cafe_rounded,
                                    color: colors.cinnamon,
                                    size: 28,
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Text(
                                      'Your menu, rewards, and order history will live here.',
                                      style: TextStyle(
                                        color: colors.oat,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  // Clear the stack so Back doesn't return to Home
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/',
                                    (route) => false,
                                  );
                                },
                                icon: Icon(
                                  Icons.logout_rounded,
                                  color: colors.cinnamon,
                                  size: 18,
                                ),
                                label: Text(
                                  'Log out',
                                  style: TextStyle(
                                    color: colors.cinnamon,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  side: BorderSide(
                                    color: colors.cinnamon,
                                    width: 1.4,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
