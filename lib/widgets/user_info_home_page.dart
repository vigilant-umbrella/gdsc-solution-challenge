import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/models/user_model.dart';
import 'package:gdsc_solution_challenge/providers/user_provider.dart';
import 'package:gdsc_solution_challenge/screens/badges_screen.dart';
import 'package:gdsc_solution_challenge/screens/user_events_dashboard.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<UserProvider>().fetchAndSetUser(),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            child: Center(child: CircularProgressIndicator()),
            // trying fixing layout shifting issue
            height: 600,
          );
        }
        if (dataSnapshot.error != null) {
          return const Center(child: Text('An error occurred!'));
        }
        return Consumer<UserProvider>(
          builder: (_, userData, _child) {
            final currentUser = userData.user;
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                currentUser.image,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Text(
                          currentUser.userName,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      currentUser.points.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        letterSpacing: 3,
                      ),
                    ),
                    const Text(
                      'points',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 375,
                  child: LayoutBuilder(
                    builder: (_, constraints) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HomeViewEventsAttendedCountCard(
                              constraints: constraints,
                              currentUser: currentUser,
                            ),
                            HomeViewEventsBadgesCard(
                              constraints: constraints,
                              currentUser: currentUser,
                            ),
                          ],
                        ),
                        HomeViewEventsViewCard(
                          constraints: constraints,
                          currentUser: currentUser,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class HomeViewEventsAttendedCountCard extends StatelessWidget {
  final BoxConstraints constraints;
  final User currentUser;
  const HomeViewEventsAttendedCountCard({
    required this.constraints,
    required this.currentUser,
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
            currentUser.eventsAttended.toString(),
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

class HomeViewEventsBadgesCard extends StatelessWidget {
  final BoxConstraints constraints;
  final User currentUser;
  const HomeViewEventsBadgesCard({
    required this.constraints,
    required this.currentUser,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeViewGlassCard(
      height: (constraints.maxHeight * 0.6) - 5,
      width: (constraints.maxWidth * 0.5) - 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const FittedBox(
            child: Text(
              "Recent Badges",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            child: Image.network(
              currentUser.badges[0]['badgeImage'],
              height: constraints.maxHeight * 0.25,
              width: constraints.maxWidth * 0.4,
              fit: BoxFit.cover,
            ),
          ),
          ElevatedButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(BadgesScreen.routeName),
            child: const Text(
              "All Badges",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeViewEventsViewCard extends StatelessWidget {
  final BoxConstraints constraints;
  final User currentUser;
  const HomeViewEventsViewCard({
    required this.constraints,
    required this.currentUser,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeViewGlassCard(
      height: (constraints.maxHeight),
      width: (constraints.maxWidth * 0.5) - 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const FittedBox(
            child: Text(
              "Upcoming Events",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            child: Image.network(
              currentUser.upcomingEvents[0].image,
              height: constraints.maxHeight * 0.3,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              child: Text(
                currentUser.upcomingEvents[0].eventTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 15,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    currentUser.upcomingEvents[0].date,
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 15,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FittedBox(
                    child: Text(
                      currentUser.upcomingEvents[0].venue,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(UserEventsDashboard.routeName),
            child: const Text(
              "View All Events",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.black,
              ),
            ),
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
