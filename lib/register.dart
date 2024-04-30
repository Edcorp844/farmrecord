import 'package:farmrecords/consts.dart';
import 'package:farmrecords/modal.dart';
import 'package:farmrecords/services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController farmNameController = TextEditingController();
  String gender = 'Male';

  @override
  void dispose() {
    emailController.dispose();
    userController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    locationController.dispose();
    farmNameController.dispose();
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
                  const SizedBox(
                    height: 30,
                  ),
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
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: input('name', userController),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Gender'),
                      const SizedBox(
                        width: 50,
                      ),
                      DropdownButton<String>(
                        value: gender,
                        onChanged: (newValue) {
                          setState(() {
                            gender = newValue!;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: 'Male',
                            child: Text('Male'),
                          ),
                          DropdownMenuItem(
                            value: 'Female',
                            child: Text('Female'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: input('email', emailController),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: input('Phone', phoneController),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: input('password', passwordController),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: input('location', locationController),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: input('Farm name', farmNameController),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CupertinoButton(
                    onPressed: () {
                      try {
                        if (userController.text.isNotEmpty &&
                            emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty &&
                            phoneController.text.isNotEmpty &&
                            locationController.text.isNotEmpty &&
                            farmNameController.text.isNotEmpty) {
                          User user = User(
                            name: userController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            phone: passwordController.text.trim(),
                            location: locationController.text.trim(),
                            farmName: farmNameController.text.trim(),
                            gender: gender,
                          );
                          StorageService.instance.insertUser(user);
                          print('User inserted successfully');
                          Navigator.of(context).pop();
                        } else {
                          showDialog(
                              context: context,
                              builder: (contex) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text('Please enter all fields'),
                                  actions: [
                                    CupertinoButton(
                                        child: Text(
                                          'Ok',
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        })
                                  ],
                                );
                              });
                        }
                      } catch (e) {
                        showDialog(
                            context: context,
                            builder: (contex) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('Error inserting user: $e'),
                                actions: [
                                  CupertinoButton(
                                      child: Text(
                                        'Ok',
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      })
                                ],
                              );
                            });
                      }
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Continue',
                      style: TextStyle(color: ksecondaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(color: kprimaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
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
          color: const Color.fromARGB(54, 255, 255, 255),
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
