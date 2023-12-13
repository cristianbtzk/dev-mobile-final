import 'package:flutter/material.dart';
import 'package:shopping_app/navigationbar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.blue.shade400,
      ),
      drawer: const CustomNavigationBar(),
      /* body: SafeArea(
        child: Column(),
      ), */
    );
  }
}
