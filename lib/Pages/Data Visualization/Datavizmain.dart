import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vw_app/Pages/Data%20Visualization/FirstGraph.dart';
import 'package:vw_app/Pages/Data%20Visualization/SecondPlot.dart';
import 'package:vw_app/Pages/Data%20Visualization/ThirdPlot.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:vw_app/Pages/Sessions/_excel.dart';

import '../../Bluetoothprovider.dart';



class Datavizmain extends StatefulWidget {
  const Datavizmain({super.key});

  @override
  State<Datavizmain> createState() => _DatavizmainState();
}

class _DatavizmainState extends State<Datavizmain> {


  final controller=PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider=Provider.of<DataProvider>(context);
    return Scaffold(
      body: Center(
        child: PageView(
          controller: controller,
          children: [
            ExcelImport(),
            Center(child: FilledButton(onPressed: (){dataProvider.createExcelFile();}, child: Text('Log')),),
            ThirdPlot(),
            SecondPlot(),
            FirstPlot(),
          ],
        ),
      ),
    );
  }

  //New added
/*
  void _disconnect() {
    connection.finish(); // Close the connection
    print('Disconnected by local host');
    setState(() {
      isConnected = false;
    });
  }

  @override
  void dispose() {
    if (isConnected) {
      _disconnect();
    }
    super.dispose();
  }

  void updateIndex() {
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
      addedDataIndexes: <int>[chartData.length - 1],
      removedDataIndexes: <int>[0],
    );


  }*/
}
