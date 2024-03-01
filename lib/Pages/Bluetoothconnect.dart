import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:vw_app/Pages/Start_ride.dart';
import 'package:vw_app/Pages/Terminal/Terminal.dart';
import 'package:vw_app/Pages/Terminaltry.dart';
import 'package:vw_app/Pages/homepage.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import '../Bluetoothprovider.dart';


class BluetoothConnect extends StatefulWidget {
  const BluetoothConnect({super.key});

  @override
  State<BluetoothConnect> createState() => _BluetoothConnectState();
}

class _BluetoothConnectState extends State<BluetoothConnect> {
  String address = '98:D3:61:F5:E8:07';
  late BluetoothConnection connection;
  List<PairData> dataList = [];
  List<LiveData> chartData=[];
  bool isConnected = false;
  String currdata='';
  String oneline='';
  int index=0;
  int time=0;
  bool isGreater= false;
  StringBuffer receiveddata= StringBuffer();

  bool isBluettothConnected=false;


  @override
  void initState() {

    super.initState();

  }

  /*void _connectToDevice() async {
    try {
      connection = await BluetoothConnection.toAddress(address);

      print('Connected to the device');
      setState(() {
        isConnected = true;
      });

      connection.input!.listen((Uint8List data) {

        String decodeddata =ascii.decode(data);

        receiveddata.write(decodeddata);

        int newlineindex= receiveddata.toString().indexOf('\n');

        while (newlineindex!=-1){

          String completeset = receiveddata.toString().substring(0,newlineindex).trim();

          print('Incoming Data: ${completeset}');

          List<String> incomingdata= completeset.split(' ');

          if (incomingdata.length==8){

            int firstdata=int.parse(incomingdata[0]);
            //double firstdatad=firstdata.toDouble();
            int seconddata=int.parse(incomingdata[1]);
            int thirddata=int.parse(incomingdata[2]);
            int fourthdata=int.parse(incomingdata[3]);
            int fifthdata=int.parse(incomingdata[4]);
            int sixthdata=int.parse(incomingdata[5]);
            int seventhdata=int.parse(incomingdata[6]);
            int eightdata=int.parse(incomingdata[7]);

            setState(() {
              dataList.add(PairData(firstdata, seconddata,thirddata,fourthdata,fifthdata,sixthdata,seventhdata,eightdata));

              chartData.add(LiveData(time++, firstdata));


              /* while (chartData.length > 19){
                chartData.removeAt(0);
                chartData.add(LiveData(time++, firstdata));
              }*/

            });

          }

          receiveddata = StringBuffer(receiveddata.toString().substring(newlineindex + 1));
          newlineindex = receiveddata.toString().indexOf('\n');


          //receiveddata.clear();
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

  */

  @override
  Widget build(BuildContext context) {

    DataProvider dataProvider = context.watch<DataProvider>();

    if(dataProvider.isConnected == true){
      setState(() {
        isBluettothConnected=true;
      });
    }

    final size=MediaQuery.of(context).size;

          return Scaffold(

              backgroundColor: Colors.black,
              body:Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 150),
                        child: Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black87,
                          border: Border(
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 50,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        width: 80,
                        height: 80,
                        margin: EdgeInsets.only(bottom: 30.0),
                        child: Image(image: AssetImage('assets/images/bluetooth.png')),
                      ),
                      Text(
                        'Connect to Bluetooth Module', style: TextStyle(
                          color: Colors.white70,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),),
                    ],
                  ))),
                      Column(
                        children: [
                          Text('Turn on the Bluetooth Connection of this device',style: TextStyle(color: Colors.white70,fontSize: 14),),
                          SizedBox(height: 20,),
                          Container(
                            child: InkWell(
                              onTap: () {
                                dataProvider.connectToDevice();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => MyHomePage())
                                );
                              },
                              child: Container(
                                width: 190,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: Offset(2, 3), // changes position of shadow
                                    ),
                                  ],
                          
                                ),
                                child: Center(
                                  child: Text(
                                    'Connect', style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              )




          );
  }


 /* void _disconnect() {
    connection.finish(); // Close the connection
    print('Disconnected by local host');
    setState(() {
      isConnected = false;
    });
  }*/

/*
 void dispose() {
    if (isConnected) {
      _disconnect();
    }
    super.dispose();
  }*/
}

class PairData {
  final double rpm;
  final double batt_vol;
  final double voltage;
  final double current1;
  final double current2;
  final double motor_temp;
  final double controller_temp;


  PairData(this.rpm, this.batt_vol, this.voltage,this.current1,this.current2,this.motor_temp,this.controller_temp);
}

class LiveData {
  final int time;
  final int speed;

  LiveData(this.time,this.speed);
}





