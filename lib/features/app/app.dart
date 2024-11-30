import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmate/env/common/globals.dart';
import 'package:pmate/env/config/themes.dart';
import 'package:pmate/features/app/navigation.dart';
import 'package:pmate/features/settings/business/appearance_settings_provider.dart';
import 'package:pmate/features/settings/business/task_settings_provider.dart';
import 'package:pmate/features/task_management/business/task_provider.dart';
import 'package:pmate/features/welcome/interface/welcome_form.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
        ChangeNotifierProvider(
          create: (context) => AppearanceSettingsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TaskSettingsProvider(),
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

            return Builder(builder: (context) {
              final settingsProvider =
                  context.watch<AppearanceSettingsProvider>()..init();
              context.watch<TaskSettingsProvider>().init();

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: Globals.appInfo.appName,
                theme: PmateThemes.light,
                darkTheme: PmateThemes.dark,
                themeMode: settingsProvider.bundle.getThemeMode,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                home: const NavigationCenter(),
              );
            });
          },
        ),
      ),
    );
  }
}
