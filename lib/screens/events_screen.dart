import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/providers/event_provider.dart';
import 'package:gdsc_solution_challenge/providers/theme_provider.dart';
import 'package:gdsc_solution_challenge/widgets/event_list.dart';
import 'package:gdsc_solution_challenge/widgets/for_you_event_list.dart';
import 'package:gdsc_solution_challenge/widgets/new_event.dart';
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

        // refresh indicator adds swipe to refresh functionality
        body: LayoutBuilder(
          builder: (context, constraints) => RefreshIndicator(
            backgroundColor: Colors.white,
            onRefresh: () => context.read<Events>().fetchAndSetAllEvents(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  children: [
                    // for you list
                    SizedBox(
                      height: constraints.maxHeight * 0.32,
                      child: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'For You',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 160,
                            width: double.infinity,
                            child: ForYouEventList(),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: constraints.maxHeight * 0.68,
                      child: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'All Events',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          // all events list
                          Expanded(
                            child: EventList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: const GlassyCustomBottomNavBar(),
        extendBody: true,
        floatingActionButton: const NewEventButton(),
      ),
    );
  }
}
