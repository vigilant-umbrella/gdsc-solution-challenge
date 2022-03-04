import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/models/event_model.dart';
import 'package:gdsc_solution_challenge/screens/event_detail_screen.dart';
import 'package:glass_kit/glass_kit.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({
    required this.event,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer.frostedGlass(
      height: 230,
      width: double.maxFinite,
      margin: const EdgeInsets.all(5),
      borderRadius: BorderRadius.circular(20),
      borderWidth: 2,
      child: LayoutBuilder(
        builder: (_, constraints) {
          return InkWell(
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
    );
  }
}
