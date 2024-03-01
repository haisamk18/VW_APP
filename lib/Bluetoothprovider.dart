import 'dart:convert';

import 'dart:io';

import 'dart:math' as math;

import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'Pages/Bluetoothconnect.dart';

import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;

class DataProvider extends ChangeNotifier {

  //Excel
  late List<double> rpmvalues=[];
  late List<double> voltagelist=[];
  late List<double> curr1list=[];
  late List<double> curr2list=[];
  late List<double> motor_templist=[];
  late List<double> controller_templist=[];
  late List<double> batt_vollist=[];



  String address = '98:D3:61:F5:E8:07';
  late BluetoothConnection connection;
  List<PairData> dataList = [];
  List<LiveData> chartData=[];
  bool isConnected = false;
  bool hasRide_started=false;
  bool createExcel=true;
  String currdata='';
  String oneline='';
  int index=0;
  int time=0;
  bool isGreater= false;
  StringBuffer receiveddata= StringBuffer();
  bool isExcelFilemade = false;

  late List<PairData> excelData =[];

  late bool navbarvisible=true;



  void Emptyexceldata() {
    if(hasRide_started==false){
      excelData=[];
    }
  }

  void connectToDevice() async {
    try {
      connection = await BluetoothConnection.toAddress(address);

      print('Connected to the device');

      isConnected =true;

      connection.input!.listen((Uint8List data) {

        String decodeddata =ascii.decode(data);

        receiveddata.write(decodeddata);

        int newlineindex= receiveddata.toString().indexOf('\n');

        while (newlineindex!=-1){

          String completeset = receiveddata.toString().substring(0,newlineindex).trim();

          print('Incoming Data: ${completeset}');

          List<String> incomingdata= completeset.split(' ');

          if (incomingdata.length==7){

            double rpm=double.parse(incomingdata[0]);
            double batt_vol=double.parse(incomingdata[1]);
            double voltage=double.parse(incomingdata[2]);
            double current1=double.parse(incomingdata[3]);
            double current2=double.parse(incomingdata[4]);
            double motor_temp=double.parse(incomingdata[5]);
            double controller_temp=double.parse(incomingdata[6]);

            /*
            int firstdata=int.parse(incomingdata[0]);
            //double firstdatad=firstdata.toDouble();
            int seconddata=int.parse(incomingdata[1]);
            int thirddata=int.parse(incomingdata[2]);
            int fourthdata=int.parse(incomingdata[3]);
            int fifthdata=int.parse(incomingdata[4]);
            int sixthdata=int.parse(incomingdata[5]);
            int seventhdata=int.parse(incomingdata[6]);
            int eightdata=int.parse(incomingdata[7]);

             */

            if(hasRide_started==true) {
              dataList.add(PairData(rpm, batt_vol,voltage,current1,current2,motor_temp,controller_temp));
              excelData.add(PairData(rpm, batt_vol,voltage,current1,current2,motor_temp,controller_temp));
            }


            //chartData.add(LiveData(time++, rpm));
            /* while (chartData.length > 19){
                chartData.removeAt(0);
                chartData.add(LiveData(time++, firstdata));
              }*/
          }

          receiveddata = StringBuffer(receiveddata.toString().substring(newlineindex + 1));
          newlineindex = receiveddata.toString().indexOf('\n');

          notifyListeners();
          //receiveddata.clear();
        }
      }).onDone(() {

        print('Disconnected by remote request');
        isConnected = false;
        dataList=[];

      });
    } catch (error) {
      print('Cannot connect, exception occurred: $error');
    }

  }

  void disconnect() {
    connection.finish(); // Close the connection
    print('Disconnected by local host');
    isConnected=false;
    notifyListeners();

  }

  void StartRide() {
    hasRide_started=true;
    notifyListeners();
  }

  void StopRide() {

    hasRide_started=false;



    notifyListeners();
  }

 void hideNavbar() {
    navbarvisible=false;
    notifyListeners();
 }
 void ShowNvabar() {
    navbarvisible=true;
    notifyListeners();
 }

  Future<List<int>> _loadExcelFileBytes() async {
    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/Output${dataList.length}.xlsx';
    final File file = File(fileName);
    return await file.readAsBytes();
  }
  //Excel Functions

  Future<void> createExcelFile() async {

    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText('Rpm');
    sheet.getRangeByName('B1').setText('Voltage');
    sheet.getRangeByName('C1').setText('Curr1');
    sheet.getRangeByName('D1').setText('Current2');
    sheet.getRangeByName('E1').setText('Motor_temp');
    sheet.getRangeByName('F1').setText('Controller_temp');
    sheet.getRangeByName('G1').setText('Batt_Voltage');






    List<int> myListrpm= [2,4,6,8,10];
    List<int> voltage=[40,50,60,70,80,90];
    List<int> batt_vol=[10,20,30,40,50,60];
    List<int> curr1=[20,80,7,3,10,70];
    List<int> curr2=[67,89,918,67,89];
    List<int> motor_temp=[10,20,30,40,87];
    List<int> controller_temp=[20,40,60,80];

    final int secondRow=2;
    final int rpmcolumn=1;
    final int volcolumn=2;
    final int curr1col=3;
    final int curr2col=4;
    final int motr_temp=5;
    final int controller_tempcol=6;
    final int batt_volcol=7;
    final bool isVertical = true;

    for( var i=0;i< excelData.length;i++) {
      rpmvalues.add(excelData[i].rpm);
      voltagelist.add(excelData[i].voltage);
      batt_vollist.add(excelData[i].batt_vol);
      curr1list.add(excelData[i].current1);
      curr2list.add(excelData[i].current2);
      controller_templist.add(excelData[i].controller_temp);
      motor_templist.add(excelData[i].motor_temp);
    }

    sheet.importList(rpmvalues, secondRow, rpmcolumn, isVertical);
    sheet.importList(voltagelist, secondRow, volcolumn, isVertical);
    sheet.importList(curr1list, secondRow,curr1col , isVertical);
    sheet.importList(curr2list, secondRow,curr2col , isVertical);
    sheet.importList(motor_templist, secondRow, motr_temp, isVertical);
    sheet.importList(controller_templist, secondRow, controller_tempcol, isVertical);
    sheet.importList(batt_vollist, secondRow, batt_volcol, isVertical);

    createExcel==true;

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();


    if (kIsWeb) {
      AnchorElement(
          href:
          'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'Output.xlsx')
        ..click();
      notifyListeners();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName =
      Platform.isWindows ? '$path\\Output${dataList.length}${math.Random().nextInt(60) + 50}.xlsx' : '$path/Output${dataList.length}${math.Random().nextInt(60) + 50}.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);

      OpenFile.open(fileName);
      isExcelFilemade=true;

      notifyListeners();
    }

    excelData.clear();

    notifyListeners();

  }



}