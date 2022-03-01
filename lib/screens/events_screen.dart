import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/providers/theme_provider.dart';
import 'package:gdsc_solution_challenge/widgets/event_view.dart';
import 'package:gdsc_solution_challenge/widgets/new_event.dart';
import 'package:gdsc_solution_challenge/widgets/glassy_bottom_navbar.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatefulWidget {
  // route name
  static const routeName = '/';

  // constructor
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
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
          children: const <Widget>[
            Center(
              child: Text('Home'),
            ),
            EventView(),
            Center(
              child: Text('Settings'),
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
