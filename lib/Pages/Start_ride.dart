import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vw_app/Pages/Rides/Ride.dart';
import 'package:vw_app/Pages/splashscreen.dart';

import '../Bluetoothprovider.dart';

class Start_Ride extends StatefulWidget {
  const Start_Ride({super.key});

  @override
  State<Start_Ride> createState() => _Start_RideState();
}

class _Start_RideState extends State<Start_Ride> {
  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider=Provider.of<DataProvider>(context);
    return dataProvider.isConnected
        ?
      Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueAccent),
            ),
            onPressed: () {
                dataProvider.StartRide();
                dataProvider.hideNavbar();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SplashScreen())
                  );
              },
            child: Text('Start Ride',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12),)),
      ),
    )
        :
      Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text('Not Connected yet..Please Connect again',style: TextStyle(color: Colors.white70),),
      ),
    );
  }
}
