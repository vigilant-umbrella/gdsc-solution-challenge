import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/providers/theme_provider.dart';
import 'package:gdsc_solution_challenge/providers/user_provider.dart';
import 'package:gdsc_solution_challenge/screens/login_screen.dart';
import 'package:gdsc_solution_challenge/services/auth_service.dart';
import 'package:gdsc_solution_challenge/widgets/loader.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:provider/provider.dart';

class BadgesScreen extends StatelessWidget {
  // route name
  static const routeName = '/badges';

  // constructor
  const BadgesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Some Error Occured'),
          );
        } else if (snapshot.hasData) {
          return const BadgesScreenLoggedIn();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}

class BadgesScreenLoggedIn extends StatefulWidget {
  const BadgesScreenLoggedIn({Key? key}) : super(key: key);

  @override
  State<BadgesScreenLoggedIn> createState() => _BadgesScreenLoggedInState();
}

class _BadgesScreenLoggedInState extends State<BadgesScreenLoggedIn> {
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: Image.network(
                            badge['badgeImage'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(badge['badgeInfo'],
                            style: const TextStyle(
                              fontSize: 16,
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
