import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.black),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.sports_soccer, size: 50, color: Colors.blue),
                  const SizedBox(height: 10),
                  Text(
                    "deaf user",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blueGrey),
            title: Text('profile', style: const TextStyle(color: Colors.white)),
            onTap: () {},
          ),

          const Spacer(),
          const Divider(color: Colors.white10),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
