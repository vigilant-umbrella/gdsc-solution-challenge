import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/providers/event_provider.dart';
import 'package:gdsc_solution_challenge/widgets/for_you_event_card.dart';
import 'package:provider/provider.dart';

class ForYouEventList extends StatelessWidget {
  const ForYouEventList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<Events>().fetchAndSetFavoriteEvents(),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (dataSnapshot.error != null) {
          return const Center(child: Text('An error occurred!'));
        }
        return Consumer<Events>(
          builder: (_, eventData, _child) => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: eventData.favoriteEvents.length,
            itemBuilder: (_, index) => ForYouEventCard(
              event: eventData.favoriteEvents[index],
            ),
          ),
        );
      },
    );
  }
}
