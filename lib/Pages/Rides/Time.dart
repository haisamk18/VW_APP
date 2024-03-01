import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  String formattedTime = DateFormat('kk:mm:ss').format(DateTime.now());
  String hour = DateFormat('a').format(DateTime.now());
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) => _update());
  }

  void _update() {
    setState(() {
      formattedTime = DateFormat('kk:mm:ss').format(DateTime.now());
      hour = DateFormat('a').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Container(
          width: 80,
          height: 90,
          child:Column(
            children: [
              Center(child: Text('${formattedTime}',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w800,fontSize:16),)),
              Center(child: Text('${hour} ',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w600,fontSize:12),)),
            ],
          ),
        ),
      ),
    );
  }
}