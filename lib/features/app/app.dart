import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmate/env/common/globals.dart';
import 'package:pmate/features/home/interface/home_page.dart';
import 'package:pmate/features/task_management/business/task_provider.dart';
import 'package:pmate/features/welcome/interface/welcome_form.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toastification/toastification.dart';

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
              return Center(
                child: CircularProgressIndicator(),
              );
              //TODO: Replace with loading animation
            }

            if (snapshot.hasData) {
              homePage = const HomePage();
            } else {
              homePage = const WelcomeFormPage();
            }

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Globals.appInfo.appName,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              darkTheme: ThemeData.dark(),
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
