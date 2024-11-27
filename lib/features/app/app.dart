import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmate/env/common/globals.dart';
import 'package:pmate/features/app/navigation.dart';
import 'package:pmate/features/task_management/business/task_provider.dart';
import 'package:pmate/features/welcome/interface/welcome_form.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Custom theme configuration
final lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF1A5F7A), // Deep blue as primary seed
  brightness: Brightness.light,
  // Custom color configurations
  primary: const Color(0xFF1A5F7A), // Deep blue
  secondary: const Color(0xFF2A9D8F), // Teal
  tertiary: const Color(0xFFE9C46A), // Gold
  surface: const Color(0xFFF8F9FA), // Light gray
  background: Colors.white,
  error: const Color(0xFFE76F51), // Coral
);

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF1A5F7A),
  brightness: Brightness.dark,
  // Custom dark mode colors
  primary: const Color(0xFF2A9D8F),
  secondary: const Color(0xFF1A5F7A),
  tertiary: const Color(0xFFE9C46A),
  surface: const Color(0xFF2D3436),
  background: const Color(0xFF1E272E),
  error: const Color(0xFFE76F51),
);

ThemeData _buildTheme(ColorScheme colorScheme) {
  return ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,

    // Text theme configuration
    textTheme: TextTheme(
      // Large titles - using Playfair Display
      displayLarge: TextStyle(
        // For very large headers
        fontFamily: 'Playfair_Display',
        fontSize: 57,
        fontWeight: FontWeight.bold,
        color: colorScheme.onBackground,
      ),
      displayMedium: TextStyle(
        // For section headers
        fontFamily: 'Playfair_Display',
        fontSize: 45,
        fontWeight: FontWeight.bold,
        color: colorScheme.onBackground,
      ),
      displaySmall: TextStyle(
        // For subsection headers
        fontFamily: 'Playfair_Display',
        fontSize: 36,
        fontWeight: FontWeight.w500,
        color: colorScheme.onBackground,
      ),

      // Regular text - using Montserrat
      bodyLarge: TextStyle(
        // For important body text
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: colorScheme.onBackground,
      ),
      bodyMedium: TextStyle(
        // For regular body text
        fontFamily: 'Montserrat',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: colorScheme.onBackground,
      ),
      bodySmall: TextStyle(
        // For captions and small text
        fontFamily: 'Montserrat',
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: colorScheme.onBackground.withOpacity(0.8),
      ),

      // Button and label text
      labelLarge: TextStyle(
        // For button text
        fontFamily: 'Montserrat',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: colorScheme.primary,
      ),
    ),
  );
}

class PmateRoot extends StatelessWidget {
  const PmateRoot({super.key});

  @override
  Widget build(BuildContext context) {
    late Widget homePage;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskProvider(),
        ),
      ],
      child: ToastificationWrapper(
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitWaveSpinner(
                  color: Color.fromARGB(255, 32, 152, 36),
                  size: 50,
                ),
              );
            }

            if (snapshot.hasData) {
              homePage = const NavigationCenter();
            } else {
              homePage = const WelcomeFormPage();
            }

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Globals.appInfo.appName,
              theme: _buildTheme(lightColorScheme),
              darkTheme: _buildTheme(darkColorScheme),
              themeMode: ThemeMode.system,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: homePage,
            );
          },
        ),
      ),
    );
  }
}
