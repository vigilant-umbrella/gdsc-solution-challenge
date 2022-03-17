import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/providers/event_provider.dart';
import 'package:gdsc_solution_challenge/providers/theme_provider.dart';
import 'package:gdsc_solution_challenge/providers/user_provider.dart';
import 'package:gdsc_solution_challenge/screens/attending_event_detail_screen.dart';
import 'package:gdsc_solution_challenge/screens/badges_screen.dart';
import 'package:gdsc_solution_challenge/screens/event_detail_screen.dart';
import 'package:gdsc_solution_challenge/screens/login_screen.dart';
import 'package:gdsc_solution_challenge/screens/main_screen.dart';
import 'package:gdsc_solution_challenge/screens/new_event_screen.dart';
import 'package:gdsc_solution_challenge/screens/organising_event_detail_screen.dart';
import 'package:gdsc_solution_challenge/screens/user_events_dashboard.dart';
import 'package:gdsc_solution_challenge/widgets/loader.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppWithProviderSetup());
}

// modify this to implement different providers
class AppWithProviderSetup extends StatelessWidget {
  const AppWithProviderSetup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // setting up provider for controlling themes
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Themes(),
        ),
      ],
      child: MyApp(),
    );
  }
}

// this will contain logic for the app to load initial contents and routes
class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error Occurred'));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => Events(),
              ),
              ChangeNotifierProvider(
                create: (_) => UserProvider(),
              ),
            ],
            child: MaterialApp(
              title: 'App',
              theme: context.watch<Themes>().currentTheme,
              debugShowCheckedModeBanner: false,
              initialRoute: NewEventScreen.routeName,
              routes: {
                LoginScreen.routeName: (_) => const LoginScreen(),
                MainScreen.routeName: (_) => const MainScreen(),
                NewEventScreen.routeName: (_) => const NewEventScreen(),
                EventDetailScreen.routeName: (_) => const EventDetailScreen(),
                UserEventsDashboard.routeName: (_) =>
                    const UserEventsDashboard(),
                BadgesScreen.routeName: (_) => const BadgesScreen(),
                AttendingEventDetailScreen.routeName: (_) =>
                    const AttendingEventDetailScreen(),
                OrganisingEventDetailScreen.routeName: (_) =>
                    const OrganisingEventDetailScreen(),
              },
            ),
          );
        }

        return MaterialApp(
          title: 'App',
          theme: context.watch<Themes>().currentTheme,
          debugShowCheckedModeBanner: false,
          home: const LoadingScreen(),
        );
      },
    );
  }
}
