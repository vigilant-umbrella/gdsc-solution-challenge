import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/models/event_model.dart';
import 'package:gdsc_solution_challenge/screens/event_detail_screen.dart';
import 'package:glass_kit/glass_kit.dart';

class ForYouEventCard extends StatelessWidget {
  final Event event;

  const ForYouEventCard({
    required this.event,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer.frostedGlass(
      height: 160,
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      borderRadius: BorderRadius.circular(20),
      borderWidth: 2,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, EventDetailScreen.routeName,
              arguments: event);
        },
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
                  height: 70,
                  width: 196,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        child: Text(
                          event.eventTitle,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
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
                              event.date,
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
                                event.venue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
