// ignore_for_file: deprecated_member_use

import 'package:farmrecords/consts.dart';
import 'package:farmrecords/insert.dart';
import 'package:farmrecords/login.dart';
import 'package:farmrecords/report.dart';
import 'package:farmrecords/services/auth.dart';
import 'package:farmrecords/services/storage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Farm extends StatefulWidget {
  const Farm({super.key});

  @override
  State<Farm> createState() => _FarmState();
}

class _FarmState extends State<Farm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.65,
          height: MediaQuery.of(context).size.height - 80,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 17, 35, 51),
          ),
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: ksecondaryColor),
                accountName: Text(
                  AuthService().getCurrentUser()!.name,
                  style: const TextStyle(
                    color: kprimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                accountEmail: Text(
                  AuthService().getCurrentUser()!.email,
                  style: const TextStyle(
                    color: kprimaryColor,
                    fontSize: 12,
                  ),
                ),
                currentAccountPicture: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: kprimaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'assets/icons.jpeg',
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              const Spacer(),
              Divider(),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  AuthService().logout();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Sign Out'),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Hello ${AuthService().getCurrentUser()!.name}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: backgroundColor,
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const InsertData()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ksecondaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'assets/create-outline.svg',
                            height: 30,
                            width: 30,
                            color: kprimaryColor,
                          ),
                          const Text(
                            'Insert a Record',
                            style:
                                TextStyle(color: kprimaryColor, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ReportPage()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ksecondaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'assets/receipt-outline.svg',
                            height: 25,
                            width: 25,
                            color: kprimaryColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Create Report',
                            style:
                                TextStyle(color: kprimaryColor, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  card('Beef', 'Beef Cattle', 'assets/beef.svg'),
                  card('Milk', 'Milk Cattle', 'assets/milking_cow.svg'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                //height: 200,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(47, 100, 128, 153),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      //height: 120,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                24, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: SvgPicture.asset(
                                          'assets/expense.svg',
                                          color: Colors.white,
                                          height: 25,
                                          width: 25,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text('Total Expenses'),
                                    ],
                                  ),
                                  const Text(
                                    '2,345',
                                    style: TextStyle(
                                        color: kprimaryColor,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: kprimaryColor),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      'More',
                                      style: TextStyle(
                                        color: kprimaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                24, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: SvgPicture.asset(
                                          'assets/hay.svg',
                                          color: Colors.white,
                                          height: 25,
                                          width: 25,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text('Last Feeding'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 45,
                                    width: 140,
                                    child: LineChart(
                                      LineChartData(
                                          gridData:
                                              const FlGridData(show: false),
                                          titlesData:
                                              const FlTitlesData(show: false),
                                          borderData: FlBorderData(show: false),
                                          lineBarsData: [
                                            LineChartBarData(
                                                dotData: const FlDotData(
                                                    show: false),
                                                isCurved: true,
                                                belowBarData: BarAreaData(
                                                  show: true,
                                                  gradient:
                                                      const LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color.fromARGB(
                                                          75, 7, 187, 241),
                                                      Colors.transparent,
                                                    ],
                                                  ),
                                                ),
                                                spots: [
                                                  FlSpot(0, 9),
                                                  FlSpot(1, 8),
                                                  FlSpot(2, 2),
                                                  FlSpot(3, 10),
                                                  FlSpot(5, 7),
                                                ])
                                          ]),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 8),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: kprimaryColor),
                                        borderRadius: BorderRadius.circular(20),
                                        color: kprimaryColor),
                                    child: const Text(
                                      'More',
                                      style: TextStyle(
                                        color: ksecondaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(47, 100, 128, 153),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(19, 255, 255, 255)),
                      child: SvgPicture.asset(
                        'assets/hay.svg',
                        height: 30,
                        width: 30,
                        color: Colors.white,
                      ),
                    ),

                    const Text('Last Bought feeds on'),
                    const Text(
                      '12 Nov, 2025',
                      style: TextStyle(color: Colors.grey),
                    ),

                    // Text()
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget card(purpose, desc, icon) => Container(
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
                  future:
                      StorageService.instance.getCattleCountForPurpose(purpose),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Text(
                        '${snapshot.data}',
                        style: TextStyle(
                          fontSize: 45,
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
