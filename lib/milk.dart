import 'package:farmrecords/consts.dart';
import 'package:farmrecords/modal.dart';
import 'package:farmrecords/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Milkpage extends StatefulWidget {
  const Milkpage({super.key});

  @override
  State<Milkpage> createState() => _MilkState();
}

class _MilkState extends State<Milkpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(47, 100, 128, 153),
        title: const Text('Milkpage'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  card('Total Milkpage', 'assets/milking_cow.svg'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                  future: StorageService.instance.getAllMilks(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Show loading indicator while waiting for the result
                    } else if (snapshot.hasError) {
                      return Text(
                          'Error: ${snapshot.error}'); // Show error message if there's an error
                    } else {
                      // Use the result of getAllCattleCount() after it's completed
                      int len = snapshot.data!.length;

                      return Column(
                        children: [
                          for (int i = 0; i < len; i++)
                            listTile(snapshot.data![i]),
                        ],
                      );
                    }
                  })
            ]),
          ),
        ),
      ),
    );
  }

  String formattedDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    return formatter.format(dateTime);
  }

  Widget listTile(Milk milk) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        height: 50,
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(47, 100, 128, 153),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(19, 255, 255, 255)),
              child: SvgPicture.asset(
                'assets/heifer.svg',
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),

            Text('${milk.liters} Liters'),
            Text(
              milk.time,
              style: const TextStyle(color: Colors.grey),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(19, 255, 255, 255)),
              child: SvgPicture.asset(
                'assets/milk.svg',
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),

            // Text()
          ],
        ),
      ),
    );
  }

  Widget card(desc, icon) => Container(
        height: 150,
        width: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: const Color.fromARGB(47, 100, 128, 153),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<int>(
                  future: StorageService.instance.getTotalMilkLiters(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text(
                        '${snapshot.data}L',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                  child: Column(
                    children: [
                      Text(desc),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(24, 255, 255, 255),
                        borderRadius: BorderRadius.circular(50)),
                    // ignore: deprecated_member_use
                    child: SvgPicture.asset(
                      icon,
                      color: Colors.white,
                      height: 30,
                      width: 30,
                    ))
              ],
            ),
          ],
        ),
      );
}
