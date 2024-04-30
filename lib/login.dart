import 'package:farmrecords/consts.dart';
import 'package:farmrecords/main.dart';
import 'package:farmrecords/register.dart';
import 'package:farmrecords/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'assets/icons.jpeg',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Diary Farm',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: input('email', emailController),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: input('password', passwordController),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CupertinoButton(
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: ksecondaryColor),
                    ),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      Future.delayed(const Duration(seconds: 3));
                      try {
                        await AuthService().login(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );

                        bool isLoggedIn = AuthService().isAuthenticated();
                        if (isLoggedIn) {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage()));

                          // Print current user after successful login
                          print(AuthService().getCurrentUser());
                        } else {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('Invalid email or password'),
                                actions: [
                                  CupertinoButton(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        }
                      } catch (e) {
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content:
                                  Text('An error occurred during login: $e'),
                              actions: [
                                CupertinoButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          },
                        );
                      }
                    },
                    color: kprimaryColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'or',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Register()));
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: kprimaryColor),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget input(placeholder, controller) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Color.fromARGB(66, 88, 88, 88),
          borderRadius: BorderRadius.circular(16)),
      child: CupertinoTextField(
        style: TextStyle(color: Colors.white),
        controller: controller,
        placeholder: placeholder,
        decoration: BoxDecoration(),
      ),
    );
  }
}
