import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BlSrW extends StatefulWidget {
  const BlSrW({Key? key}) : super(key: key);

  @override
  State<BlSrW> createState() => _BlSrState();
}

class _BlSrState extends State<BlSrW> {
  String address = '98:D3:61:F5:E8:07';
  late BluetoothConnection connection;
  List<String> dataList = [];
  String CurrentData='';

  @override
  void initState() {
    super.initState();
    _connectToDevice();
  }

  void _connectToDevice() async {
    BluetoothConnection.toAddress(address).then((_connection) {
      print('Connected to the device');
      connection = _connection;

      connection.input!.listen((Uint8List data) {
        //print('Data incoming: ${ascii.decode(data)}');

        CurrentData+=ascii.decode(data);

        if (CurrentData.contains('!')) {
          // Process the accumulated data
          setState(() {
            dataList.add(CurrentData.toString());
          });

          // Clear the current data for the next set
          CurrentData = '';
        }

        // Update UI with the received data


        if (ascii.decode(data).contains('!')) {
          connection.finish(); // Closing connection
          print('Disconnecting by local host');
        }
      }).onDone(() {
        print('Disconnected by remote request');
      });
    }).catchError((error) {
      print('Cannot connect, exception occurred: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Serial Data'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return ListTile(
              selectedTileColor: Colors.green,
              title: Text(dataList[index].toString()),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    connection.finish(); // Close the connection when the widget is disposed
    super.dispose();
  }
}