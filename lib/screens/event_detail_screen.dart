import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdsc_solution_challenge/models/event_model.dart';
import 'package:gdsc_solution_challenge/providers/theme_provider.dart';
import 'package:gdsc_solution_challenge/screens/login_screen.dart';
import 'package:gdsc_solution_challenge/services/auth_service.dart';
import 'package:gdsc_solution_challenge/widgets/loader.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailScreen extends StatelessWidget {
  // route name
  static const routeName = '/event-detail';

  // constructor
  const EventDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Some Error Occured'),
          );
        } else if (snapshot.hasData) {
          return const EventDetailScreenLoggedIn();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}

class EventDetailScreenLoggedIn extends StatefulWidget {
  // constructor
  const EventDetailScreenLoggedIn({Key? key}) : super(key: key);

  @override
  State<EventDetailScreenLoggedIn> createState() =>
      _EventDetailScreenLoggedInState();
}

class _EventDetailScreenLoggedInState extends State<EventDetailScreenLoggedIn> {
  // variables
  late String _mapStyle;

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.json').then((string) {
      _mapStyle = string;
    });
  }

  void _navigateTo(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    await launch(uri.toString());
  }

  @override
  Widget build(BuildContext context) {
    final panelOpenHeight = MediaQuery.of(context).size.height * 0.8;

    final event = ModalRoute.of(context)!.settings.arguments as Event;
    return Container(
      decoration: BoxDecoration(
        gradient: context.watch<Themes>().currentThemeBackgroundGradient,
      ),
      child: Scaffold(
          appBar: AppBar(
            title: Text(event.eventTitle),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _navigateTo(event.location.lat, event.location.lng);
            },
            child: const Icon(Icons.navigation),
          ),
          body: SlidingUpPanel(
            maxHeight: panelOpenHeight,
            renderPanelSheet: false,
            defaultPanelState: PanelState.OPEN,
            panel: GlassContainer.clearGlass(
              height: panelOpenHeight,
              width: double.maxFinite,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: LayoutBuilder(
                builder: (_, constraints) {
                  return Container(
                    margin: const EdgeInsets.only(top: 2),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          ),
                          child: Image.network(
                            event.image,
                            height: (constraints.maxHeight * 0.35) - 2,
                            width: constraints.maxWidth - 4,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: constraints.maxHeight * 0.65,
                          padding: const EdgeInsets.all(10),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                const SizedBox(height: 10),
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
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          event.venue,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Join'),
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Organized by:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      event.organizerName,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'About the event:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      event.description,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            body: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(event.location.lat, event.location.lng),
                zoom: 15,
              ),
              onMapCreated: (controller) {
                controller.setMapStyle(_mapStyle);
              },
              markers: {
                Marker(
                  markerId: MarkerId(event.eventTitle),
                  position: LatLng(event.location.lat, event.location.lng),
                ),
              },
            ),
          )),
    );
  }
}
