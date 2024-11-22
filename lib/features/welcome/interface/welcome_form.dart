import 'package:flutter/material.dart';
import 'package:pmate/features/welcome/business/welcome_provider.dart';
import 'package:pmate/features/welcome/interface/welcome_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeFormPage extends StatefulWidget {
  const WelcomeFormPage({super.key});

  @override
  State<WelcomeFormPage> createState() => _WelcomeFormPageState();
}

class _WelcomeFormPageState extends State<WelcomeFormPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    void onProceed() {
      WelcomeProvider.userName = _controller.text.trim();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomePage(),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(local.intro_hello),
                Text(local.intro_name_field),
                TextField(
                  controller: _controller,
                ),
                ElevatedButton(
                  onPressed: onProceed,
                  child: Text(local.proceed),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
