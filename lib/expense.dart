import 'package:farmrecords/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpansesScreen extends StatefulWidget {
  const ExpansesScreen({super.key});

  @override
  State<ExpansesScreen> createState() => _ExpansesScreenState();
}

class _ExpansesScreenState extends State<ExpansesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(47, 100, 128, 153),
        title: const Text('Expenses'),
        centerTitle: true,
      ),
      body:const  Center(
        child: Text(
          'Nothing to show here yet',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}


class Feeding extends StatefulWidget {
  const Feeding({super.key});

  @override
  State<Feeding> createState() => _FeedingState();
}

class _FeedingState extends State<Feeding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(47, 100, 128, 153),
        title: const Text('Feeding'),
        centerTitle: true,
      ),
      body:const  Center(
        child: Text(
          'Nothing to show here yet',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}