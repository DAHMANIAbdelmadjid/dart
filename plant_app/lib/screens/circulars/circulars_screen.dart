import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'components/body.dart';
import 'components/custom_drawer.dart';

class CircularsScreen extends StatelessWidget {
  const CircularsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: const Text('Circulars'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // TODO: Implement profile action
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: const Body(),
    );
  }
}
