import 'package:farmrecords/consts.dart';
import 'package:farmrecords/modal.dart';
import 'package:farmrecords/services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class Health extends StatefulWidget {
  const Health({super.key});

  @override
  State<Health> createState() => _HealthState();
}

class _HealthState extends State<Health> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(47, 100, 128, 153),
        title: Text('Health'),
        centerTitle: true,
      ),
      body:  FutureBuilder<List<Diseased>>(
  future: StorageService.instance.getAllDiseased(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator(); // Show loading indicator while waiting for the result
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}'); // Show error message if there's an error
    } else {
      // Use the result of getAllDiseased() after it's completed
      int totalDiseasedCount = snapshot.data!.length;
      if (totalDiseasedCount <= 0) {
        return const Center(child: Text('No Health data to show yet'));
      } else {
       return  SafeArea(
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 16.0),
         child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
             for(int i =0; i<totalDiseasedCount; i++ )
              listTile(snapshot.data?[i].cattleId, snapshot.data?[i].disease, snapshot.data?[i].times)
            ]
            ),
         ),
         ),
         );
       }
       } 
       },
     )
      );
    
   
  }

  Widget listTile(id, disease, times){

    return Padding(
      padding: const EdgeInsets.only( bottom: 10.0),
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
                                                        color: const Color.fromARGB(19, 255, 255, 255)
                                                    ),
                                                  child: SvgPicture.asset(
                                                      'assets/dry_cow.svg',
                                                       height: 30,
                                                        width: 30,
                                                        color: Colors.white,
                                                      ),
                                                ),
                                                
                                                Text(id),
                                                 Text(disease, style: TextStyle(color: Colors.grey),),
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        color: const Color.fromARGB(19, 255, 255, 255)
                                                    ),
                                                  child: SvgPicture.asset(
                                                      'assets/medication.svg',
                                                       height: 30,
                                                        width: 30,
                                                        color: times<=0?Colors.red:Colors.green
                                                      ),
                                                ),
                                                Stack(
                                                  children: [
                                                    Container(
                                                        padding: EdgeInsets.all(5),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20),
                                                            color: const Color.fromARGB(19, 255, 255, 255)
                                                        ),
                                                      child: SvgPicture.asset(
                                                          'assets/needDoctor.svg',
                                                           height: 30,
                                                            width: 30,
                                                            color: times<=0?Colors.red:Colors.green,
                                                          ),
                                                    ),
                                                    Positioned(
                                                      left: 20,
                                                      
                                                      child: Container(
                                                        padding: EdgeInsets.all(2),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(50),
                                                          color: Colors.red
                                                        ),
                                                      child: Center(child: Text('x$times', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)),
                                                    ))
                                                  ],
                                                ),
                                               
                                              
                                            ],
                                        ),
                                    ),
    );
  }
}