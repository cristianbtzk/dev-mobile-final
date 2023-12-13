import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context) => Material(
      color: Colors.blue.shade400,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top,
            bottom: 24,
          ),
          child: const Column(
            children: [
              CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/vetores-premium/perfil-de-avatar-ilustracoes-vetoriais-para-site-redes-sociais-icone-de-perfil-de-usuario_495897-230.jpg?w=2000'),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'User',
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
              Text(
                'user@email.com',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(12),
      child: Wrap(
        runSpacing: 2,
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/exercises');
            },
          ),
          const Divider(color: Colors.black),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Categories'),
            onTap: () {},
          ),
        ],
      ),
    );
