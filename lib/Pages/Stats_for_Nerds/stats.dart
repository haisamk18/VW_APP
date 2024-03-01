import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Bluetoothprovider.dart';

class Stats extends StatelessWidget {
  const Stats({super.key});

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider=Provider.of<DataProvider>(context);

    return dataProvider.hasRide_started
      ?
     Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(top: 40),

        child: Center(

          child: Wrap(
            spacing: 5.0,
            runSpacing: 5.0,
            children: [
              Container(
                child: Center(child: Text('Peak rpm: ${dataProvider.dataList.last.rpm}',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),)),
                width: 170,
                height: 65,
                decoration: ShapeDecoration(
                  color: Color(0x637C7C7C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: -1,
                    )
                  ],
                ),
              ),
              Container(
                child: Center(child: Text('Max Batt_Vol:  ${dataProvider.dataList.last.batt_vol}',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),)),
                width: 170,
                height: 65,
                decoration: ShapeDecoration(
                  color: Color(0x637C7C7C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: -1,
                    )
                  ],
                ),
              ),
              Container(
                child: Center(child: Text('Max Voltage:  ${dataProvider.dataList.last.voltage}',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),)),
                width: 170,
                height: 65,
                decoration: ShapeDecoration(
                  color: Color(0x637C7C7C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: -1,
                    )
                  ],
                ),
              ),
              Container(
                child: Center(child: Text('Max Current1:  ${dataProvider.dataList.last.current1}',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),)),
                width: 170,
                height: 65,
                decoration: ShapeDecoration(
                  color: Color(0x637C7C7C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: -1,
                    )
                  ],
                ),
              ),
              Container(
                child: Center(child: Text('Max Current2:  ${dataProvider.dataList.last.current2}',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),)),
                width: 170,
                height: 65,
                decoration: ShapeDecoration(
                  color: Color(0x637C7C7C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: -1,
                    )
                  ],
                ),
              ),
              Container(
                child: Center(child: Text('Max Motor_temp:  ${dataProvider.dataList.last.motor_temp}',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),)),
                width: 170,
                height: 65,
                decoration: ShapeDecoration(
                  color: Color(0x637C7C7C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: -1,
                    )
                  ],
                ),
              ),
              Container(
                child: Center(child: Text('Max Controller_temp:  ${dataProvider.dataList.last.controller_temp}',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),)),
                width: 170,
                height: 65,
                decoration: ShapeDecoration(
                  color: Color(0x637C7C7C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: -1,
                    )
                  ],
                ),
              ),
              Container(
                width: 170,
                height: 65,
                decoration: ShapeDecoration(
                  color: Color(0x637C7C7C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: -1,
                    )
                  ],
                ),
              ),
              Container(
                width: 170,
                height: 65,
                decoration: ShapeDecoration(
                  color: Color(0x637C7C7C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: -1,
                    )
                  ],
                ),
              ),
              Container(
                width: 170,
                height: 65,
                decoration: ShapeDecoration(
                  color: Color(0x637C7C7C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: -1,
                    )
                  ],
                ),
              ),
              Container(
                width: 170,
                height: 65,
                decoration: ShapeDecoration(
                  color: Color(0x637C7C7C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: -1,
                    )
                  ],
                ),
              ),
              Container(
                child: Center(child: Text('Speed',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),)),
                width: 170,
                height: 65,
                decoration: ShapeDecoration(
                  color: Color(0x637C7C7C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: -1,
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    )
      :
    Scaffold(
        backgroundColor: Colors.black,
        body: dataProvider.isConnected
            ?
        Container(
          child: Center(
            child: Text('To see stats make sure you have started the ride..',style: TextStyle(color: Colors.white70),),
          ),
        )
            :
        Container(
          child: Column(
            children: [
              Center(heightFactor:10,child: Text('Not Connected',style: TextStyle(color: Colors.white70),),),
              ElevatedButton(onPressed: () {dataProvider.connectToDevice();}, child: Text('Connect Again')),
            ],
          ),
        )
    );
  }
}
