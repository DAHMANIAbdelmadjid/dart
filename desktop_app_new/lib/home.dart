import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var sIdex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        NavigationRail(
          backgroundColor: const Color.fromARGB(255, 196, 195, 195),
          // indicatorColor: Colors.cyan[50],
          labelType: NavigationRailLabelType.all,
          selectedLabelTextStyle: const TextStyle(color: Colors.indigo),
          selectedIndex: sIdex,
          destinations: const [
            NavigationRailDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: Text("Home")),
            NavigationRailDestination(
              selectedIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings_outlined),
              label: Text("Settings"),
            )
          ],
          onDestinationSelected: (index) {
            setState(() {
              sIdex = index;
            });
          },
        ),
        const Expanded(
          child: Center(
            child: Text("Selected Page Content Here"),
          ),
        ),
        const VerticalDivider(thickness: 2, width: 2),
      ],
    ));
  }
}
