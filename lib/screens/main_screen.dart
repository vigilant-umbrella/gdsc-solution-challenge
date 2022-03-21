import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/providers/theme_provider.dart';
import 'package:gdsc_solution_challenge/screens/login_screen.dart';
import 'package:gdsc_solution_challenge/services/auth_service.dart';
import 'package:gdsc_solution_challenge/widgets/event_view.dart';
import 'package:gdsc_solution_challenge/widgets/home_view.dart';
import 'package:gdsc_solution_challenge/widgets/loader.dart';
import 'package:gdsc_solution_challenge/widgets/new_event.dart';
import 'package:gdsc_solution_challenge/widgets/glassy_bottom_navbar.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  // route name
  static const routeName = '/';

  // constructor
  const MainScreen({Key? key}) : super(key: key);

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
          return const MainScreenLoggedIn();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}

class MainScreenLoggedIn extends StatefulWidget {
  const MainScreenLoggedIn({Key? key}) : super(key: key);

  @override
  State<MainScreenLoggedIn> createState() => _MainScreenLoggedInState();
}

class _MainScreenLoggedInState extends State<MainScreenLoggedIn> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // conditionally renderring appbar text
  String _appBarText() {
    switch (_currentIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Events';
      default:
        return 'Settings';
    }
  }

  void _handleBottomNavBarTap(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: context.watch<Themes>().currentThemeBackgroundGradient,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_appBarText()),
        ),

        /// creating a pageview for different views of the main screen based on
        /// the bottom navigation bar selected index
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            const HomeView(),
            const EventView(),
            Center(
              child: ElevatedButton(
                onPressed: () => AuthService().signOut(),
                child: const Text('Sign Out'),
              ),
            ),
          ],
        ),
        bottomNavigationBar: GlassyCustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _handleBottomNavBarTap,
        ),
        extendBody: true,
        floatingActionButton:
            (_currentIndex == 1) ? const NewEventButton() : null,
      ),
    );
  }
}
