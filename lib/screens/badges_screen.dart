import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/providers/theme_provider.dart';
import 'package:gdsc_solution_challenge/providers/user_provider.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:provider/provider.dart';

class BadgesScreen extends StatefulWidget {
  const BadgesScreen({Key? key}) : super(key: key);

  // route name
  static const routeName = '/badges';

  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserProvider>();
    return Container(
      decoration: BoxDecoration(
        gradient: context.watch<Themes>().currentThemeBackgroundGradient,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Badges'),
        ),
        body: LayoutBuilder(
          builder: (_, constraints) => GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: userData.user.badges
                .map(
                  (badge) => GlassContainer.clearGlass(
                    height: constraints.maxHeight * 0.5 - 10,
                    width: constraints.maxHeight * 0.5 - 10,
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
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(18)),
                          child: Image.network(
                            badge['badgeImage'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(badge['badgeInfo'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        extendBody: true,
      ),
    );
  }
}
