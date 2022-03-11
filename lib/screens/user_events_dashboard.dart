import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/custom_components/bottom_navy_bar.dart';
import 'package:gdsc_solution_challenge/models/event_model.dart';
import 'package:gdsc_solution_challenge/providers/theme_provider.dart';
import 'package:gdsc_solution_challenge/providers/user_provider.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class UserEventsDashboard extends StatefulWidget {
  static const routeName = '/user-events-dashboard';

  const UserEventsDashboard({Key? key}) : super(key: key);

  @override
  State<UserEventsDashboard> createState() => _UserEventsDashboardState();
}

class _UserEventsDashboardState extends State<UserEventsDashboard> {
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
        return 'Attending Events';
      case 1:
        return 'Organising Events';
      default:
        return 'Something went wrong';
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
        extendBody: true,
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: const <Widget>[
            UserEventsList(
              isAttendingEvents: true,
            ),
            UserEventsList(
              isAttendingEvents: false,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigation(
          currentIndex: _currentIndex,
          onTap: _handleBottomNavBarTap,
        ),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  BottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  final _containerHeight = Platform.isIOS ? 100.00 : 70.00;

  @override
  Widget build(BuildContext context) {
    return GlassContainer.frostedGlass(
      height: _containerHeight,
      width: double.maxFinite,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.zero,
        bottomRight: Radius.zero,
      ),
      borderColor: Colors.white.withOpacity(0.8),
      borderWidth: 1,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: false,
        backgroundColor: Colors.transparent,
        containerHeight: _containerHeight,
        onItemSelected: (index) => onTap(index),
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.event_outlined),
            title: const Text('Attending Events'),
            activeColor: Theme.of(context).primaryColor,
            textAlign: TextAlign.center,
            inactiveColor: Theme.of(context).colorScheme.onPrimary,
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: const Icon(Icons.extension_outlined),
            title: const Text('Organising'),
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Theme.of(context).colorScheme.onPrimary,
          ),
        ],
      ),
    );
  }
}

class UserEventsList extends StatelessWidget {
  final bool isAttendingEvents;
  const UserEventsList({
    required this.isAttendingEvents,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserProvider>();
    final events = isAttendingEvents
        ? userData.getEventsAttending
        : userData.getEventsOrganising;
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (ctx, i) {
        return UserEventsCard(events[i]);
      },
    );
  }
}

class UserEventsCard extends StatelessWidget {
  final Event event;

  const UserEventsCard(this.event, {Key? key}) : super(key: key);

  bool _isFutureEvent() {
    DateTime now = DateTime.now();
    DateTime eventDate = DateFormat('dd/MM/yyyy').parse(event.date);
    return eventDate.isAfter(now);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GlassContainer.frostedGlass(
          height: 230,
          width: double.maxFinite,
          margin: const EdgeInsets.all(5),
          borderRadius: BorderRadius.circular(20),
          borderWidth: 2,
          child: LayoutBuilder(
            builder: (_, constraints) {
              return InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                        ),
                        child: Image.network(
                          event.image,
                          height: 150,
                          width: constraints.maxWidth - 4,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                event.eventTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Text(event.tags[0]),
                                      const VerticalDivider(
                                        thickness: 1,
                                        color: Colors.white,
                                      ),
                                      Text(event.tags[1]),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      event.date,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        if (_isFutureEvent())
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  "🤩 Upcomming",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
