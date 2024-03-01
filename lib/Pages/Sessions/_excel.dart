import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';

import '../../Bluetoothprovider.dart';

class ExcelImport extends StatefulWidget {
  const ExcelImport({super.key});

  @override
  State<ExcelImport> createState() => _ExcelImportState();
}

class _ExcelImportState extends State<ExcelImport> {
   late List<double> rpmvalues;
   late List<double> voltagelist;
   late List<double> curr1list;
   late List<double> curr2list;
   late List<double> motor_templist;
   late List<double> controller_templist;
   late List<double> batt_vollist;



   List<int> myListrpm= [2,4,6,8,10];
   List<int> voltage=[40,50,60,70,80,90];
   List<int> batt_vol=[10,20,30,40,50,60];
   List<int> curr1=[20,80,7,3,10,70];
   List<int> curr2=[67,89,918,67,89];
   List<int> motor_temp=[10,20,30,40,87];
   List<int> controller_temp=[20,40,60,80];

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider=Provider.of<DataProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: FilledButton(onPressed: (){createExcel();}, child: Text('Log Data')),),
        if(dataProvider.dataList.length >10)
           FilledButton(onPressed: (){dataProvider.createExcelFile();}, child: Text('Log Excel'))
      ],
    );
  }


  /*
   List<double> getRpmdata() {
     DataProvider dataProvider=Provider.of<DataProvider>(context);
     List<double> rpmoutput=[];
     for (var i=0;i<dataProvider.dataList!.length;i++){
       rpmoutput.add(dataProvider.dataList[i].rpm);
     }
     return rpmoutput;
   }

   List<double> getVoldata() {
     DataProvider dataProvider=Provider.of<DataProvider>(context);
     List<double> voloutput=[];
     for (var i=0;i<dataProvider.dataList!.length;i++){
       voloutput.add(dataProvider.dataList[i].voltage);
     }
     return voloutput;
   }

   List<double> getCurr1data() {
     DataProvider dataProvider=Provider.of<DataProvider>(context);
     List<double> curr1output=[];
     for (var i=0;i<dataProvider.dataList!.length;i++){
       curr1output.add(dataProvider.dataList[i].current1);
     }
     return curr1output;
   }

   List<double> getcurr2data() {
     DataProvider dataProvider=Provider.of<DataProvider>(context);
     List<double> curr2output=[];
     for (var i=0;i<dataProvider.dataList!.length;i++){
       curr2output.add(dataProvider.dataList[i].current2);
     }
     return curr2output;
   }

   List<double> controllertempdata() {
     DataProvider dataProvider=Provider.of<DataProvider>(context);
     List<double> controlleroutput=[];
     for (var i=0;i<dataProvider.dataList!.length;i++){
       controlleroutput.add(dataProvider.dataList[i].rpm);
     }
     return controlleroutput;
   }

   List<double> motortempdata() {
     DataProvider dataProvider=Provider.of<DataProvider>(context);
     List<double> motortempoutput=[];
     for (var i=0;i<dataProvider.dataList!.length;i++){
       motortempoutput.add(dataProvider.dataList[i].rpm);
     }
     return motortempoutput;
   }

   List<double> batteryVoldata() {
     DataProvider dataProvider=Provider.of<DataProvider>(context);
     List<double> battoutput=[];
     for (var i=0;i<dataProvider.dataList!.length;i++){
       battoutput.add(dataProvider.dataList[i].rpm);
     }
     return battoutput;
   }

   */


   Future<void> createExcel() async {

     final Workbook workbook = Workbook();
     final Worksheet sheet = workbook.worksheets[0];
     sheet.getRangeByName('A1').setText('Rpm');
     sheet.getRangeByName('B1').setText('Voltage');
     sheet.getRangeByName('C1').setText('Batt_Voltage');
     sheet.getRangeByName('D1').setText('Current1');
     sheet.getRangeByName('E1').setText('Current2');
     sheet.getRangeByName('F1').setText('Controller_temp');
     sheet.getRangeByName('G1').setText('Motor_temp');

     final int secondRow=2;
     final int rpmcolumn=1;
     final int volcolumn=2;
     final int curr1col=3;
     final int curr2col=4;
     final int motr_temp=5;
     final int controller_tempcol=6;
     final int batt_volcol=7;
     final bool isVertical = true;

;


     sheet.importList(myListrpm, secondRow, rpmcolumn, isVertical);
     sheet.importList(voltage, secondRow, volcolumn, isVertical);
     sheet.importList(batt_vol, secondRow,curr1col , isVertical);
     sheet.importList(curr1, secondRow,curr2col , isVertical);
     sheet.importList(curr2, secondRow, motr_temp, isVertical);
     sheet.importList(controller_temp, secondRow, controller_tempcol, isVertical);
     sheet.importList(motor_temp, secondRow, batt_volcol, isVertical);


     final List<int> bytes = workbook.saveAsStream();
     workbook.dispose();

     if (kIsWeb) {
       AnchorElement(
           href:
           'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
         ..setAttribute('download', 'Output.xlsx')
         ..click();
     } else {
       final String path = (await getApplicationSupportDirectory()).path;
       final String fileName =
       Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
       final File file = File(fileName);
       await file.writeAsBytes(bytes, flush: true);

       OpenFile.open(fileName);
     }
   }






}






