
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Nbls extends StatefulWidget {
  const Nbls({Key? key}) : super(key: key);

  @override
  State<Nbls> createState() => _BlSrState();
}

class _BlSrState extends State<Nbls> {
  String address = '98:D3:61:F5:E8:07';
  late BluetoothConnection connection;
  List<PairData> dataList = [];
  bool isConnected = false;
  String currentData = '';

  @override
  void initState() {
    super.initState();
    _connectToDevice();
  }

  void _connectToDevice() async {

    try {
      connection = await BluetoothConnection.toAddress(address);

      String decodeddata='';
      int index=0;
      print('Connected to the device');
      setState(() {
        isConnected = true;
      });

      connection.input!.listen((Uint8List data) {

       decodeddata=ascii.decode(data);

       print('Data incoming: $decodeddata');

       while(index < decodeddata.length && decodeddata[index]!='10') {
         currentData += decodeddata[index];

       }
       print('Received data: ${currentData}');
       List<String> datapair = currentData.trim().split(' ');

       if (datapair.length == 2) {
         int firstNumber = int.parse(datapair[0]);
         int secondNumber = int.parse(datapair[1]);

         setState(() {
           dataList.add(PairData(firstNumber, secondNumber));
         });
       }

       currentData='';

        if (ascii.decode(data).contains('!')) {
          _disconnect();
        }
      }).onDone(() {
        print('Disconnected by remote request');
        setState(() {
          isConnected = false;
        });
      });
    } catch (error) {
      print('Cannot connect, exception occurred: $error');
    }
  }



  void _disconnect() {
    connection.finish(); // Close the connection
    print('Disconnected by local host');
    setState(() {
      isConnected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Serial Data'),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: isConnected ? _disconnect : _connectToDevice,
              child: Text(isConnected ? 'Disconnect' : 'Connec'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context,index) {
                  return ListTile(
                    title: Text('Pair: ${dataList[index].speed} ${dataList[index].torque}'),
                  );

                }
              )
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (isConnected) {
      _disconnect();
    }
    super.dispose();
  }
}

class PairData {
  PairData(this.speed,this.torque);
  final int speed;
  final int torque;
}
