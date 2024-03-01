import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vw_app/Pages/Bluetoothconnect.dart';
import 'package:vw_app/Pages/Rides/Ride.dart';
import 'package:vw_app/Pages/Start_ride.dart';
import 'package:vw_app/Pages/homepage.dart';
import 'package:vw_app/Pages/splashscrn.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jumping_dot/jumping_dot.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});



  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  

  
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }


  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 2);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Ride()));
  }

  initScreen(BuildContext context){
    final size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You are being Redirected to Ride Page.',style: TextStyle(color: Colors.white),),
              Text('Wait a second..',style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }
}

class JumpingDots extends StatelessWidget {
  const JumpingDots({super.key, required Color color, required int radius, required int numberOfDots, required Duration animationDuration});

  @override
  Widget build(BuildContext context) {
     Duration animationDuration;
     return Scaffold(
      body: Center(
        child: JumpingDots(
          color: Colors.yellow,
          radius: 10,
          numberOfDots: 3,
          animationDuration :Duration(milliseconds: 200),
        ),
      ),
    );;
  }
}

