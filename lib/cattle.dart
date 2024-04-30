import 'package:farmrecords/consts.dart';
import 'package:farmrecords/modal.dart';
import 'package:farmrecords/services/storage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Cattle extends StatefulWidget {
  const Cattle({super.key});

  @override
  State<Cattle> createState() => _CattleState();
}

class _CattleState extends State<Cattle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(47, 100, 128, 153),
        title: const Text('Cattle'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Catttle>>(
        stream: StorageService
            .instance.cattleStream, // Use the stream instead of future
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            int cattleCount = snapshot.data!.length;
            Map<String, double> percentages = {};
            snapshot.data!.forEach((cattle) {
              percentages[cattle.type] =
                  (percentages[cattle.type] ?? 0) + (1 / cattleCount) * 100;
            });
            if (cattleCount <= 0) {
              return const Center(child: Text('No cattle to show yet'));
            } else {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 200,
                          child: PieChart(
                            PieChartData(
                              sections: percentages.entries.map((entry) {
                                return PieChartSectionData(
                                  titleStyle: TextStyle(fontSize: 10),
                                  color: _getColorForType(
                                      entry.key), // Get color based on type
                                  value: entry.value, // Use percentage as value
                                  title:
                                      '${entry.key}s (${entry.value.toStringAsFixed(0)}%)', // Show type and percentage in title
                                  radius: 80,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Cattle Records'),
                        const SizedBox(
                          height: 10,
                        ),
                        for (int i = 0; i < cattleCount; i++)
                          listTile(snapshot.data![i].cattleId,
                              snapshot.data![i].type, snapshot.data![i].purpose)
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }

  Widget listTile(id, type, use) {
    String icon;
    String useicon;

    if (use == 'Milk') {
      useicon = 'assets/milk.svg';
    } else {
      useicon = 'assets/beef.svg';
    }
    if (type == 'Heifer') {
      icon = 'assets/heifer.svg';
    } else if (type == 'Bull') {
      icon = 'assets/bull.svg';
    } else if (type == 'Pregnant') {
      icon = 'assets/fertilization.svg';
    } else {
      icon = 'assets/heifer.svg';
    }
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
                icon,
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),

            Text(id),
            Text(
              type,
              style: TextStyle(color: Colors.grey),
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(19, 255, 255, 255)),
              child: SvgPicture.asset(
                useicon,
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

  Color _getColorForType(String type) {
    switch (type) {
      case 'Bull':
        return Color.fromARGB(255, 3, 175, 175);
      case 'Heifer':
        return Color.fromARGB(255, 4, 41, 83);
      case 'Calf':
        return Color.fromARGB(255, 201, 6, 113);
      case 'Pregnant':
        return Color.fromARGB(118, 3, 177, 55);
      case 'Castrated':
        return Colors.purple;
      default:
        return Colors.grey; // Default color if type is unknown
    }
  }
}
