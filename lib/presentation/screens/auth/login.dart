import 'package:bankbank/data/repositories/user_repository.dart';
import 'package:bankbank/domain/usecases/user_usecase.dart';
import 'package:bankbank/presentation/common/theme_data.dart';
import 'package:bankbank/presentation/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late final UserUsecase userUsecase;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    userUsecase = UserUsecase(UserRepository());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Log in to BankBank',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              SvgPicture.asset(
                'assets/svg/signup.svg',
                height: 200.0,
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              var user = await userUsecase.login
                                (_usernameController
                                  .text, _passwordController.text);
          
                              if (user == null){
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid username or password')));
                              }
          
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage()));
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $e')),
                              );
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blueDark,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 48,
                              vertical: 18), // Button padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Button border radius
                          ),
                        ),
                        child: isLoading ? const CircularProgressIndicator
                          (color: Colors.white) : const Text('Log in')
                      ),
                      const SizedBox(height: 8.0),
                      TextButton(
                        onPressed: () {
                          // Navigate to the sign up page
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.blueDark,
                          padding: const EdgeInsets.symmetric(horizontal: 48,
                              vertical: 18), // Button padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Button border radius
                          ),
                        ),
                        child: const Text('Sign up', style: TextStyle(fontWeight:
                        FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

}
