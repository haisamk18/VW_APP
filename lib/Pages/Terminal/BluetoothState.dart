import 'package:flutter/material.dart';

class BluetoothState extends StatefulWidget {
  const BluetoothState({super.key});

  @override
  State<BluetoothState> createState() => _BluetoothStateState();
}

class _BluetoothStateState extends State<BluetoothState> {
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body:
      Stack(
        children: [
          Container(
            child: Center(
              child: InkWell(
                child: Container(
                  width: 190,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Connect',style: TextStyle(
                      color: Colors.white70,fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 300,
              left: size.width/2.7,
              child: Center(child: Text('Connect to Bluetooth Module',style: TextStyle(color: Colors.white70,fontSize: 17,fontWeight: FontWeight.bold),))),
        ],
      )

    );
  }
}
