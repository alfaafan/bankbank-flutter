import 'package:bankbank/presentation/common/app_bar.dart';
import 'package:bankbank/presentation/common/theme_data.dart';
import 'package:bankbank/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).refresh();
      Provider.of<UserProvider>(context, listen: false).fetchUser();
    });
    return Scaffold(
      backgroundColor: AppColors.blueDark,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight), // Adjust height as needed
        child: BankBankAppBar(title: 'Profile'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          var user = userProvider.user;
          if (userProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SvgPicture.asset('assets/svg/profile.svg', height: 150.0),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Profile Information',
                    style: TextStyle(fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 16.0),
                  Card(
                      margin: EdgeInsets.zero,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                              children: [
                                ListTile(
                                  title: const Text('Username',
                                      style: TextStyle(fontSize: 12)),
                                  subtitle: Text(user?.username ?? 'No username',
                                      style: const TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.bold, color: AppColors.blueDark)),
                                ),
                                ListTile(
                                  title: const Text('Email',
                                      style: TextStyle(fontSize: 12)),
                                  subtitle: Text(user?.email ?? 'No email',
                                      style: const TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.bold, color: AppColors.blueDark)),
                                ),
                                ListTile(
                                  title: const Text('Name',
                                      style: TextStyle(fontSize: 12)),
                                  subtitle: Text("${user!.firstName} ${user.lastName}",
                                      style: const TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.bold, color: AppColors.blueDark)),
                                ),
                                ListTile(
                                  title: const Text('Phone Number',
                                      style: TextStyle(fontSize: 12)),
                                  subtitle: Text(user.phone,
                                      style: const TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.bold, color: AppColors.blueDark)),
                                ),
                                ListTile(
                                  title: const Text('Date of Birth',
                                      style: TextStyle(fontSize: 12)),
                                  subtitle: Text(DateFormat('dd-MM-yyyy')
                                      .format(user.dateOfBirth),
                                      style: const TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.bold, color: AppColors.blueDark)),
                                )
                              ]
                          )
                      )
                  )
                ],
              ),
            );
          }
        }
      )
    );
  }
}
