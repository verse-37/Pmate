import 'package:flutter/material.dart';
import 'package:pmate/env/common/buttons.dart';
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
                        Text(WelcomeProvider.script[i].first),
                        Text(WelcomeProvider.script[i].second),
                      ],
                    );
                  },
                ),
              ),
              Container(
                alignment: Alignment(0, 0.75),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: prevPage,
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: n,
                    ),
                    IconButton(
                      onPressed: nextPage,
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                ),
              ),
              if (onLastPage)
                Container(
                  alignment: Alignment(0, 0.95),
                  child: LargeButton(
                    text: local.intro_button,
                    action: openAuthPage,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
