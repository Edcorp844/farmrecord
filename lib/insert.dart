import 'package:farmrecords/consts.dart';
import 'package:farmrecords/modal.dart';
import 'package:farmrecords/services/auth.dart';
import 'package:farmrecords/services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InsertData extends StatefulWidget {
  const InsertData({super.key});

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  TextEditingController cattleIdController = TextEditingController();
  TextEditingController diseaseController = TextEditingController();
  TextEditingController medicationController = TextEditingController();
  TextEditingController timesController = TextEditingController();
  // Initialize text editing controllers for milk data fields
  final dateController = TextEditingController();
  final processController = TextEditingController();
  final cratesController = TextEditingController();
  final litersController = TextEditingController();
  final _litersController = TextEditingController();

  String selectedvalue = 'Beef';
  String selecteType = 'Bull';

  String _selectedTime = 'Morning';
  DateTime _selectedDate = DateTime.now();

  String formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';

  @override
  void dispose() {
    cattleIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(47, 100, 128, 153),
        title: Text('Insert'),
        centerTitle: true,
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: CupertinoButton(
                        color: Colors.green,
                        child: SizedBox(
                          //width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/total_cow.svg',
                                height: 30,
                                width: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Add new cow',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Insert Cattle Data'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Add form fields for cattle data entry
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Cattle ID'),
                                        controller: cattleIdController,
                                      ),

                                      DropdownButton<String>(
                                        value: selecteType,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selecteType = newValue!;
                                          });
                                        },
                                        items: [
                                          DropdownMenuItem(
                                            value: 'Bull',
                                            child: Text('Bull'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'Calf',
                                            child: Text('Calf'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'Pregnant',
                                            child: Text('Pregnant'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'Heifer',
                                            child: Text('Heifer'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'Castrated',
                                            child: Text('Castrated'),
                                          ),
                                        ],
                                      ),
                                      DropdownButton<String>(
                                        value: selectedvalue,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedvalue = newValue!;
                                          });
                                        },
                                        items: [
                                          DropdownMenuItem(
                                            value: 'Beef',
                                            child: Text('Beef'),
                                          ),
                                          DropdownMenuItem(
                                            value: 'Milk',
                                            child: Text('Milk'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (cattleIdController.text.isNotEmpty) {
                                        await StorageService.instance
                                            .insertCattle(
                                          cattleIdController.text
                                              .trim(), // Cattle ID
                                          selecteType, // Cattle type
                                          selectedvalue, // Selected purpose (Beef or Milk)
                                        );
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        })),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: CupertinoButton(
                        color: Colors.red,
                        child: SizedBox(
                          //width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/health.svg',
                                height: 30,
                                width: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Add a Health Record',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Add Diseased Data'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: cattleIdController,
                                        decoration: InputDecoration(
                                            labelText: 'Cattle ID'),
                                      ),
                                      TextField(
                                        controller: diseaseController,
                                        decoration: InputDecoration(
                                            labelText: 'Disease'),
                                      ),
                                      TextField(
                                        controller: medicationController,
                                        decoration: InputDecoration(
                                            labelText: 'Medication'),
                                      ),
                                      TextField(
                                        controller: timesController,
                                        keyboardType: TextInputType.number,
                                        decoration:
                                            InputDecoration(labelText: 'Times'),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Perform actions when Cancel button is pressed
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      // Perform actions when Add button is pressed
                                      String cattleId =
                                          cattleIdController.text.trim();
                                      String disease =
                                          diseaseController.text.trim();
                                      String medication =
                                          medicationController.text.trim();
                                      int times = int.tryParse(
                                              timesController.text.trim()) ??
                                          0;

                                      // Create a Diseased object and insert it into the database
                                      Diseased diseased = Diseased(
                                        date: DateTime.now(),
                                        cattleId: cattleId,
                                        disease: disease,
                                        medication: medication,
                                        times: times,
                                        userId:
                                            AuthService().getCurrentUser()?.id!,
                                      );
                                      await StorageService.instance
                                          .insertDiseased(diseased);

                                      // Close the dialog
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Add'),
                                  ),
                                ],
                              );
                            },
                          );
                        })),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: CupertinoButton(
                        color: Colors.cyan,
                        child: SizedBox(
                          //width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/milk.svg',
                                height: 30,
                                width: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Add a Milk Record',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Insert Milk Data'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DropdownButton<String>(
                                        value: _selectedTime,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 18,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                        underline: Container(
                                          height: 2,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectedTime = newValue!;
                                          });
                                        },
                                        items: ['Morning', 'Evening']
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                      TextFormField(
                                        controller: litersController,
                                        decoration: const InputDecoration(
                                            labelText: 'Cow Id'),
                                      ),
                                      TextFormField(
                                        controller: _litersController,
                                        decoration: const InputDecoration(
                                            labelText: 'Liters'),
                                        keyboardType: TextInputType
                                            .number, // Set keyboard type for numbers
                                      ),
                                      TextButton(
                                        onPressed: () => showDatePicker(
                                          context: context,
                                          initialDate: _selectedDate,
                                          firstDate: DateTime(
                                              DateTime.now().year,
                                              1,
                                              1), // Allow selection from beginning of year
                                          lastDate: DateTime
                                              .now(), // Limit selection to current day
                                          selectableDayPredicate: (DateTime
                                                  day) =>
                                              day.isBefore(DateTime.now().add(
                                                  const Duration(
                                                      days:
                                                          1))), // Disable future dates
                                        ).then((date) {
                                          if (date != null) {
                                            setState(() {
                                              _selectedDate = date;
                                            });
                                          }
                                        }),
                                        child: Text(
                                            'Select Date: ${formatDate(_selectedDate)}'),
                                      )
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Save'),
                                    onPressed: () {
                                      if (litersController.text.isEmpty) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('Error'),
                                              content: const Text(
                                                  'Please enter the number of liters.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        return; // Exit onPressed function if validation fails
                                      }

                                      // Extract milk data from controllers
                                      int liters = int.tryParse(
                                              litersController.text.trim()) ??
                                          0;

                                      // Create a Milk object with extracted data
                                      Milk milk = Milk(
                                        date: _selectedDate,
                                        cowID: litersController.text.trim(),
                                        time:
                                            _selectedTime, // Use current date and time
                                        liters: liters,
                                        userId:
                                           AuthService().getCurrentUser()!.id!
                                      );

                                      // Call method to insert milk data into the database
                                      StorageService.instance.insertMilk(milk);

                                      // Close the dialog
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        })),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: CupertinoButton(
                    color: const Color.fromARGB(255, 241, 4, 142),
                    child: SizedBox(
                      //width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/expense.svg',
                            height: 30,
                            width: 30,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Add an expense',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController itemController =
                              TextEditingController();
                          TextEditingController amountController =
                              TextEditingController();

                          return AlertDialog(
                            title: Text('Insert Expense'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: itemController,
                                    decoration:
                                        InputDecoration(labelText: 'Item'),
                                  ),
                                  TextFormField(
                                    controller: amountController,
                                    decoration:
                                        InputDecoration(labelText: 'Amount'),
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Save'),
                                onPressed: () async {
                                  String item = itemController.text.trim();
                                  int amount = int.tryParse(
                                          amountController.text.trim()) ??
                                      0;

                                  if (item.isNotEmpty && amount > 0) {
                                    Expense expense = Expense(
                                        item: item,
                                        amount: amount,
                                        date: DateTime.now(),
                                        userId: 0);

                                    await StorageService.instance
                                        .insertExpense(expense);

                                    Navigator.of(context).pop();
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content:
                                              Text('Please enter valid data'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: CupertinoButton(
                    color: const Color.fromARGB(255, 14, 69, 172),
                    child: SizedBox(
                      //width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/pasture.svg',
                            height: 30,
                            width: 30,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Add Feeding Record',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController sacksController =
                              TextEditingController();

                          return AlertDialog(
                            title: Text('Insert Feeding Data'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: sacksController,
                                    decoration:
                                        InputDecoration(labelText: 'Sacks'),
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Save'),
                                onPressed: () async {
                                  int sacks = int.tryParse(
                                          sacksController.text.trim()) ??
                                      0;

                                  if (sacks > 0) {
                                    Feeding feeding = Feeding(
                                        sacks: sacks,
                                        date: DateTime.now(),
                                        userId: 0);

                                    await StorageService.instance
                                        .insertFeeding(feeding);

                                    Navigator.of(context).pop();
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content: Text(
                                              'Please enter a valid number of sacks'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
