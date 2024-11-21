import 'package:flutter/material.dart';
import 'package:pmate/features/welcome/business/welcome_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WelcomeProvider.init(context);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [],
          ),
          SmoothPageIndicator(
            controller: _pageController,
            count: WelcomeProvider.script.length,
          )
        ],
      ),
    );
  }
}
