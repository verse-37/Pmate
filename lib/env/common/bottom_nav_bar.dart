import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pmate/env/common/primitives.dart';

class PmateBottomNavBar extends StatefulWidget {
  const PmateBottomNavBar({
    super.key,
    required this.subpages,
  });

  final List<Pair<IconData, String>> subpages;

  @override
  State<PmateBottomNavBar> createState() => _PmateBottomNavBarState();
}

class _PmateBottomNavBarState extends State<PmateBottomNavBar> {
  int selectedIndex = 0;

  List<Color> colors = [
    Colors.purple,
    Colors.pink,
    Colors.amber[600]!,
    Colors.teal,
    Colors.lightBlue,
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (theme.brightness == Brightness.dark) {
      return GNav(
        gap: 8,
        backgroundColor: Colors.black,
        padding: const EdgeInsets.all(10),
        activeColor: Colors.white,
        color: Colors.white,
        iconSize: 24,
        textStyle: theme.textTheme.bodyMedium,
        duration: const Duration(milliseconds: 400),
        tabBackgroundColor: Colors.grey[800]!,
        tabMargin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        selectedIndex: selectedIndex,
        onTabChange: (value) {
          if (value != selectedIndex) {
            setState(() {
              selectedIndex = value;
            });
          }
        },
        tabs: List.generate(
          widget.subpages.length,
          (index) {
            return GButton(
              icon: widget.subpages[index].first,
              text: widget.subpages[index].second,
            );
          },
        ),
      );
    } else {
      return GNav(
        gap: 8,
        color: Colors.grey[600]!,
        activeColor: Colors.black,
        iconSize: 24,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: const Duration(milliseconds: 400),
        tabBackgroundColor: Colors.grey[100]!,
        backgroundColor: theme.colorScheme.surface,
        tabs: List.generate(
          widget.subpages.length,
          (index) {
            return GButton(
              icon: widget.subpages[index].first,
              text: widget.subpages[index].second,
            );
          },
        ),
        selectedIndex: selectedIndex,
        onTabChange: (value) {
          if (value != selectedIndex) {
            setState(() {
              selectedIndex = value;
            });
          }
        },
      );
    }
  }
}
