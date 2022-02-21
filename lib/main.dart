import 'package:flutter/material.dart';
import 'package:gdsc_solution_challenge/providers/theme_provider.dart';
import 'package:gdsc_solution_challenge/widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppWithProviderSetup());
}

class AppWithProviderSetup extends StatelessWidget {
  const AppWithProviderSetup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // setting up provider for controlling themes
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Themes(),
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: context.watch<Themes>().currentTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // removing the debug banner from devenvironment
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: context.watch<Themes>().currentThemeBackgroundGradient,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }
}
