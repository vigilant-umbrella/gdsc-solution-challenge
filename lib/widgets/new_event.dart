import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/screens/new_event_screen.dart';

class NewEventButton extends StatefulWidget {
  const NewEventButton({Key? key}) : super(key: key);

  @override
  State<NewEventButton> createState() => _NewEventButtonState();
}

class _NewEventButtonState extends State<NewEventButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () =>
          Navigator.of(context).pushNamed(NewEventScreen.routeName),
      child: const Icon(Icons.add),
    );
  }
}
