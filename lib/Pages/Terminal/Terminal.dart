import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vw_app/Pages/Controlller/Blcserial.dart';
import 'package:vw_app/Pages/Rides/PowerNew.dart';
import 'package:vw_app/Pages/Sessions/_excel.dart';
import 'package:vw_app/Pages/Sessions/sqflite_first.dart';
import 'package:vw_app/Pages/Start_ride.dart';
import 'package:vw_app/Pages/Terminal/BluetoothState.dart';
import 'package:vw_app/Pages/Terminal/Inputs.dart';
import 'package:vw_app/Pages/Terminaltry.dart';

import '../../Bluetoothprovider.dart';

class Terminal extends StatelessWidget {
  const Terminal({super.key});

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider=Provider.of<DataProvider>(context);
    final controller=PageController(initialPage: 0);
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       scrollBehavior: AppScrollBehavior(),
       home: Scaffold(
        body: Center(
          child: PageView(
            controller: controller,
            children: [
               dataProvider.isConnected? Terminaltry():Center(child: Text('Not Connected'),),
             // ExcelImport(),
             // DataDisplayPage(),
              Inputs(),
              Start_Ride(),
              dataProvider.hasRide_started ?PowerPlot() :Text('Ride Not started')
              //  BluetoothState(),
             ,PowerPlot(),
           //  BlSr();
            ],
          ),
        ),
           ),
     );;
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
