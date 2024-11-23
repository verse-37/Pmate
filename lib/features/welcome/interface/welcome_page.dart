import 'package:flutter/material.dart';
import 'package:pmate/features/user_authentication/interface/auth_page.dart';
import 'package:pmate/features/welcome/business/welcome_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();
  bool onLastPage = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WelcomeProvider.init(context);
    final local = AppLocalizations.of(context);
    final n = WelcomeProvider.script.length;

    Future<void> prevPage() async {
      _pageController.previousPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }

    Future<void> nextPage() async {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }

    void openAuthPage() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuthenticationPage(),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              PageView(
                onPageChanged: (index) {
                  setState(() {
                    onLastPage = index == n - 1;
                  });
                },
                controller: _pageController,
                children: List.generate(
                  n,
                  (i) {
                    return Column(
                      children: [
                        Text(WelcomeProvider.script[i].a),
                        Text(WelcomeProvider.script[i].b),
                      ],
                    );
                  },
                ),
              ),
              Container(
                alignment: Alignment(0, 0.7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => prevPage(),
                      child: Text(local.previous),
                    ),
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: n,
                    ),
                    ElevatedButton(
                      onPressed: () => nextPage(),
                      child: Text(local.next),
                    )
                  ],
                ),
              ),
              if (onLastPage)
                Container(
                  alignment: Alignment(0, 0.8),
                  child: ElevatedButton(
                    onPressed: openAuthPage,
                    child: Text(local.intro_button),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
