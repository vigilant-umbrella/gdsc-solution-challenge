import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/widgets/garbage_segregation.dart';
import 'package:gdsc_solution_challenge/widgets/user_info_home_page.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const UserInfo(),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
            height: 175,
            child: LayoutBuilder(
              builder: (_, constraints) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeViewSortingCameraCard(
                    constraints: constraints,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 70),
        ],
      ),
    );
  }
}

class HomeViewSortingCameraCard extends StatelessWidget {
  final BoxConstraints constraints;
  const HomeViewSortingCameraCard({
    required this.constraints,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const GarbageMenu()));
      },
      child: HomeViewGlassCard(
        height: (constraints.maxHeight * 0.9),
        width: (constraints.maxWidth) - 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            FittedBox(
              child: Text(
                "Scan and Sort",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(
              Icons.camera_alt,
              size: 48,
            ),
          ],
        ),
      ),
    );
  }
}
