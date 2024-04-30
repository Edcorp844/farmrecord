
// ignore_for_file: deprecated_member_use

import 'package:farmrecords/cattle.dart';
import 'package:farmrecords/consts.dart';
import 'package:farmrecords/farm.dart';
import 'package:farmrecords/health.dart';
import 'package:farmrecords/login.dart';
import 'package:farmrecords/milk.dart';
import 'package:farmrecords/services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.instance.initDB('data.db');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm Records App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:  kprimaryColor,
        useMaterial3: true,
        brightness: Brightness.dark
      ),
      home: const LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      
        tabBar: CupertinoTabBar(
          backgroundColor:  const Color.fromARGB(47, 100, 128, 153),
          items: [
          BottomNavigationBarItem(
            label: 'Farm',
            icon: SvgPicture.asset(
              'assets/farm.svg',
              width: 30,
              height: 30,
              color: Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/farm.svg',
              width: 30,
              height: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Cattle',
            icon: SvgPicture.asset(
              'assets/cow.svg',
              width: 40,
              height: 40,
              color: Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/cow.svg',
              width: 40,
              height: 40,
              color: Theme.of(context).primaryColor,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Health',
            icon: SvgPicture.asset(
              'assets/heart.svg',
              width: 40,
              height: 40,
              color: Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/heart.svg',
              width: 40,
              height: 40,
              color: Theme.of(context).primaryColor,
            ),
          ),
          BottomNavigationBarItem(
            label: 'milk',
            icon: SvgPicture.asset(
               'assets/milk-bottle.svg',
              width: 40,
              height: 30,
              color: Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/milk-bottle.svg',
              width: 40,
              height: 30,
              color: Theme.of(context).primaryColor,
            ),
          )
        ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return const Farm();

            case 1:
              return const Cattle();

            case 2:
              return const Health();

            case 3:
              return const Milkpage();

            default:
              return const Farm();
          }
        });
  }
}
