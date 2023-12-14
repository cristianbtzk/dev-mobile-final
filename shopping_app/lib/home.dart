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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 250),
                  child: const Image(
                    image: AssetImage('assets/home_page.png'),
                  ),
                ),
                const Text('Shopping app', style: TextStyle(fontSize: 24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
