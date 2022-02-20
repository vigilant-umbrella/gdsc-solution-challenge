import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Solutions Challenge',
      home: DefaultPage(),
    );
  }
}

class DefaultPage extends StatefulWidget {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  int pageIndex = 0;

  final pages = [
    const HomePage(),
    const EventsPage(),
    const HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 71, 52, 52).withOpacity(0.25),
        iconSize: 35,
        selectedFontSize: 20,
        selectedIconTheme: const IconThemeData(
          color: Colors.amberAccent,
          size: 40,
        ),
        selectedItemColor: Colors.amberAccent,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Extra',
          ),
        ],
        currentIndex: pageIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Image.network(
            'https://webgradients.com/public/webgradients_png/179%20Fabled%20Sunset.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            scale: 1,
          ),
          SafeArea(
            child: Center(
              child: GlassmorphicContainer(
                  width: 350,
                  height: 750,
                  borderRadius: 20,
                  blur: 20,
                  alignment: Alignment.bottomCenter,
                  border: 2,
                  linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFffffff).withOpacity(0.1),
                      const Color(0xFFFFFFFF).withOpacity(0.05),
                    ],
                    stops: const [
                      0.1,
                      1,
                    ],
                  ),
                  borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFffffff).withOpacity(0.5),
                      const Color((0xFFFFFFFF)).withOpacity(0.5),
                    ],
                  ),
                  child: null),
            ),
          ),
        ],
      ),
    );
  }
}

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Image.network(
            'https://webgradients.com/public/webgradients_png/179%20Fabled%20Sunset.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            scale: 1,
          ),
          Positioned(
              child: SafeArea(
                child: Center(
                  child: GlassmorphicContainer(
                      width: 350,
                      height: 200,
                      borderRadius: 20,
                      blur: 20,
                      alignment: Alignment.bottomCenter,
                      border: 2,
                      linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFffffff).withOpacity(0.1),
                          const Color(0xFFFFFFFF).withOpacity(0.05),
                        ],
                        stops: const [
                          0.1,
                          1,
                        ],
                      ),
                      borderGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFffffff).withOpacity(0.5),
                          const Color((0xFFFFFFFF)).withOpacity(0.5),
                        ],
                      ),
                      child: null),
                ),
              ),
              top: 10,
              left: 10),
          Positioned(
            child: SafeArea(
              child: Center(
                child: GlassmorphicContainer(
                    width: 350,
                    height: 100,
                    borderRadius: 20,
                    blur: 20,
                    alignment: Alignment.bottomCenter,
                    border: 2,
                    linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFffffff).withOpacity(0.1),
                        const Color(0xFFFFFFFF).withOpacity(0.05),
                      ],
                      stops: const [
                        0.1,
                        1,
                      ],
                    ),
                    borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFffffff).withOpacity(0.5),
                        const Color((0xFFFFFFFF)).withOpacity(0.5),
                      ],
                    ),
                    child: null),
              ),
            ),
            top: 250,
            left: 10,
          ),
        ],
      ),
    );
  }
}
