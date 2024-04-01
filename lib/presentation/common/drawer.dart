import 'package:bankbank/data/model/account.dart';
import 'package:bankbank/data/model/card.dart';
import 'package:bankbank/data/model/role.dart';
import 'package:bankbank/data/model/user.dart';
import 'package:bankbank/presentation/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer header with user information (optional)
          // DrawerUserHeader(), // Replace with your custom widget

          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {
              // Navigate to profile page
              Navigator.pushNamed(context, '/profile'); // Assuming route name
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigate to settings page
              Navigator.pushNamed(context, '/settings'); // Assuming route name
            },
          ),
          // Add more menu items as needed
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Logout user, clear hive box, redirect to login page
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Hive.box<User>('userBox').clear();
                            Hive.box<Account>('accountBox').clear();
                            Hive.box<UserCard>('cardBox').clear();
                            Hive.box<Role>('roleBox').clear();
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                return const LoginPage();
                              }));
                            });

                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No'),
                        ),
                      ],
                    );
                  });

            },
          ),
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text('Close'),
            onTap: () => Navigator.pop(context), // Close the drawer
          ),
        ],
      ),
    );
  }
}
