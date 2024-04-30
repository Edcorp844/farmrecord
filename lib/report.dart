import 'dart:io';
import 'package:farmrecords/consts.dart';
import 'package:farmrecords/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:farmrecords/services/storage.dart';
import 'package:pdf/pdf.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; // Updated import
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String formattedDate(DateTime? date) {
    final formatter = DateFormat('EEEE, MMMM d, y');
    return formatter.format(date!).toString();
  }

 Future<File> _generateAndSavePDF() async {
  final milk = await StorageService.instance.getAllMilks();
  
  final document = pw.Document();

  document.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Text(
              'Milk Records',
              style: const pw.TextStyle(color: PdfColors.green, fontSize: 30),
            ),
            pw.Table(
              border: pw.TableBorder.all(),
              //defaultColumnWidth: pw.FixedColumnWidth(150),
              
              children: [
                pw.TableRow(
                  children: [
                    pw.Center(child: pw.Text('Date', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20))),
                    pw.Center(child: pw.Text('Cow ID', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20))),
                    pw.Center(child: pw.Text('Time', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20))),
                    pw.Center(child: pw.Text('Liters', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20))),
                  ],
                ),
                for (var element in milk)
                  pw.TableRow(
                    children: [
                      pw.Center(child: pw.Text(formattedDate(element.date), style:const  pw.TextStyle(fontSize: 20))),
                      pw.Center(child: pw.Text(element.cowID, style:const  pw.TextStyle(fontSize: 20))),
                      pw.Center(child: pw.Text(element.time, style:const  pw.TextStyle(fontSize: 20))),
                      pw.Center(child: pw.Text(element.liters.toString(), style:const  pw.TextStyle(fontSize: 20))),
                    ],
                  ),
              ],
            ),
          ],
        );
      },
    ),
  );

  final List<int> bytes = await document.save();

  // Save the bytes to a file
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  final file = File('$path/report.pdf');
  await file.writeAsBytes(bytes);
  return file;
}


  String _formatDataItem(dynamic value) {
    // Implement logic to format individual data items for the report
    return value.toString(); // Placeholder for formatting
  }

  // Assuming you have a function to format and structure data for the report
  // This could return a PdfLayoutElement (like PdfGrid or PdfTable)
  dynamic _formatReportData(Map<String, List<Map<String, dynamic>>> allData) {
    // Initialize a string to hold the formatted data
    String formattedData = '';
    formattedData += '${AuthService().getCurrentUser()?.farmName} Report\n';

    // Iterate over each table in the allData map
    allData.forEach((tableName, tableData) {
      // Add the table name as a title
      formattedData += '$tableName\n';

      // Get the keys of the first data row to use as column titles
      final columnTitles =
          tableData.isNotEmpty ? tableData.first.keys.toList() : [];

      // Remove 'id' and 'userId' from column titles
      columnTitles.remove('id');
      columnTitles.remove('userId');

      // Add column titles to the formatted data
      formattedData += columnTitles.join('\t\t\t') + '\n';

      // Format and add each row of data to the formatted data
      tableData.forEach((rowData) {
        final formattedRow = columnTitles.map((column) {
          final value = rowData[column];
          if (value is DateTime) {
            return formattedDate(value);
            // Format date without time
          } else {
            return _formatDataItem(value);
          }
        }).join('\t');
        formattedData += '$formattedRow\n';
      });

      // Add a new line between tables
      formattedData += '\n';
    });
    return formattedData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(47, 100, 128, 153),
        title: const Text('Report'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/save-outline.svg',
              width: 25,
              height: 25,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder<File>(
        future: _generateAndSavePDF(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a circular progress indicator while the report is being generated
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Show an error message if there's an error generating the report
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Show the PDF viewer to preview the generated report
            return SfPdfViewer.file(
              snapshot.data!,
            );
          }
        },
      ),
    );
  }
}
