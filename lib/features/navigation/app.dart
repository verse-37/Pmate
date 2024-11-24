import 'package:flutter/material.dart';
import 'package:pmate/env/common/globals.dart';
import 'package:pmate/features/task_management/business/task_provider.dart';
import 'package:pmate/features/welcome/interface/welcome_form.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toastification/toastification.dart';

class PmateRoot extends StatelessWidget {
  const PmateRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskProvider(),
        ),
      ],
      child: ToastificationWrapper(
        child: MaterialApp(
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
          home: const WelcomeFormPage(),
        ),
      ),
    );
  }
}
