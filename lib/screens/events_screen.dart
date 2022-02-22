import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/providers/event_provider.dart';
import 'package:gdsc_solution_challenge/providers/theme_provider.dart';
import 'package:gdsc_solution_challenge/widgets/event_card.dart';
import 'package:gdsc_solution_challenge/widgets/glassy_bottom_navbar.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatelessWidget {
  // route name
  static const routeName = '/';

  // constructor
  const EventsScreen({Key? key}) : super(key: key);

  // own properties

  // lifecycle methods

  // helper functions

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: context.watch<Themes>().currentThemeBackgroundGradient,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Events'),
        ),
        body: FutureBuilder(
          future: context.read<Events>().fetchAndSetEvents(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (dataSnapshot.error != null) {
              return const Center(
                child: Text('An error occurred!'),
              );
            }
            return Consumer<Events>(
              builder: (ctx, eventData, _) => ListView.builder(
                itemCount: eventData.events.length,
                itemBuilder: (ctx, i) {
                  return EventCard(
                    event: eventData.events[i],
                  );
                },
              ),
            );
          },
        ),
        bottomNavigationBar: const GlassyCustomBottomNavBar(),
        extendBody: true,
      ),
    );
  }
}
