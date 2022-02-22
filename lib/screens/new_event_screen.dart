import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/providers/theme_provider.dart';
import 'package:gdsc_solution_challenge/widgets/glassy_bottom_navbar.dart';
import 'package:provider/provider.dart';

class NewEventScreen extends StatelessWidget {
  // route name
  static const routeName = '/new_event_form';

  // constructor
  const NewEventScreen({Key? key}) : super(key: key);

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
        extendBody: true,
      ),
    );
  }
}
