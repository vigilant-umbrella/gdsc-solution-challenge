import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/providers/event_provider.dart';
import 'package:gdsc_solution_challenge/providers/theme_provider.dart';
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
        body: const Center(
          child: Text('Events'),
        ),
        bottomNavigationBar: const GlassyCustomBottomNavBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<Events>(context, listen: false).fetchAndSetEvents();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
