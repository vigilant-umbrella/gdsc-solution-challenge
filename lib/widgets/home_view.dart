import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/widgets/user_info_home_page.dart';
import 'package:glass_kit/glass_kit.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const UserInfo(),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(10),
            height: 350,
            child: LayoutBuilder(
              builder: (_, constraints) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeViewEventsAttendedCountCard(
                        constraints: constraints,
                      ),
                      // HomeViewGlassCard(
                      //   height: (constraints.maxHeight * 0.6) - 5,
                      //   width: (constraints.maxWidth * 0.5) - 5,
                      // ),
                    ],
                  ),
                  // HomeViewGlassCard(
                  //   height: constraints.maxHeight,
                  //   width: (constraints.maxWidth * 0.5) - 5,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeViewEventsAttendedCountCard extends StatelessWidget {
  final BoxConstraints constraints;
  const HomeViewEventsAttendedCountCard({
    required this.constraints,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeViewGlassCard(
      height: (constraints.maxHeight * 0.4) - 5,
      width: (constraints.maxWidth * 0.5) - 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const FittedBox(
            child: Text(
              "Events Attended",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            "2",
            style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}

class HomeViewGlassCard extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  const HomeViewGlassCard({
    required this.height,
    required this.width,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer.clearGlass(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
      gradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.2),
          Colors.white.withOpacity(0.2),
        ],
      ),
      borderGradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.8),
          Colors.white.withOpacity(0.8),
        ],
      ),
      child: child,
    );
  }
}
