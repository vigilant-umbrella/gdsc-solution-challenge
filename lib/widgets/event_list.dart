import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/providers/event_provider.dart';
import 'package:gdsc_solution_challenge/widgets/event_card.dart';
import 'package:provider/provider.dart';

class EventList extends StatelessWidget {
  const EventList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    );
  }
}
