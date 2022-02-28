import 'package:gdsc_solution_challenge/custom_components/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

class GlassyCustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const GlassyCustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer.clearGlass(
      height: 70,
      width: double.maxFinite,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.zero,
        bottomRight: Radius.zero,
      ),
      borderColor: Colors.transparent,
      borderWidth: 0,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: false,
        backgroundColor: Colors.transparent,
        containerHeight: 70,
        onItemSelected: (index) => onTap(index),
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            activeColor: Theme.of(context).primaryColor,
            textAlign: TextAlign.center,
            inactiveColor: Theme.of(context).colorScheme.onPrimary,
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: const Icon(Icons.calendar_today),
            title: const Text('Events'),
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Theme.of(context).colorScheme.onPrimary,
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: const Icon(Icons.settings),
            title: const Text('Settings'),
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Theme.of(context).colorScheme.onPrimary,
          ),
        ],
      ),
    );
  }
}
