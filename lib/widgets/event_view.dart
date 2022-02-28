import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/providers/event_provider.dart';
import 'package:gdsc_solution_challenge/widgets/event_list.dart';
import 'package:gdsc_solution_challenge/widgets/for_you_event_list.dart';
import 'package:provider/provider.dart';

class EventView extends StatelessWidget {
  const EventView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
    );
  }
}
