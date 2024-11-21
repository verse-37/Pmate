import 'package:flutter/material.dart';
import 'package:pmate/features/welcome/business/welcome_provider.dart';
import 'package:provider/provider.dart';
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
    final provider = context.watch<WelcomeProvider>();
    provider.init(context);

    return ChangeNotifierProvider(
      create: (context) => WelcomeProvider(),
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: [],
            ),
            SmoothPageIndicator(
                controller: _pageController, count: provider.script.length)
          ],
        ),
      ),
    );
  }
}
