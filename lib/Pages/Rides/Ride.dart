import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:vw_app/Pages/Rides/Power.dart';
import 'package:vw_app/Pages/Rides/PowerNew.dart';

import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:vw_app/Pages/Rides/Time.dart';
import 'package:vw_app/Pages/Sessions/_excel.dart';
import 'package:vw_app/Pages/homepage.dart';

import '../../Bluetoothprovider.dart';

class Ride extends StatefulWidget {
  const Ride({super.key});

  @override
  State<Ride> createState() => _RideState();
}

class _RideState extends State<Ride> {
   late List<double> speed;

   @override
   void initState() {
     speed=_getSpeed();
     Timer.periodic(const Duration(seconds: 1), _SpeedData);
     SystemChrome.setPreferredOrientations([
       DeviceOrientation.landscapeRight,
       DeviceOrientation.landscapeLeft,
     ]);
     super.initState();
   }
   void dispose() {
     SystemChrome.setPreferredOrientations(
         [
           DeviceOrientation.portraitUp
         ]
     );
   }


  @override
  Widget build(BuildContext context) {

    DataProvider dataProvider=Provider.of<DataProvider>(context);

     double blcurrvalue=dataProvider.dataList.last.rpm;
     double factor=0.1885*0.62;
     double kmhvalue=blcurrvalue*factor;

    return WillPopScope(
        child: Scaffold(
      backgroundColor: Colors.black87,
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.42,
            height: double.infinity,
            color: Colors.black87,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.8,
                  padding: EdgeInsets.only(top: 30),
                  child: Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 0,left: 0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.lightBlue,
                            width: 4.0,
                          ),
                        ),
                        child: SfRadialGauge(
                            enableLoadingAnimation: true,
                            animationDuration: 2000,
                            backgroundColor: Colors.black87,
                            axes: <RadialAxis>[
                              RadialAxis(
                                  radiusFactor: 1,
                                  minimum: 0 ,maximum: 8,
                                  ticksPosition: ElementsPosition.outside,
                                  majorTickStyle: MajorTickStyle(color: Colors.white70),
                                  axisLabelStyle: GaugeTextStyle(
                                      color: Colors.white70,
                                      fontSize: 10,
                                      fontFamily: 'Times',
                                      fontStyle: FontStyle.italic
                                  ),
                                  labelOffset: 2,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                      startValue: 0,endValue: 6,color: Colors.green,startWidth: 2,endWidth: 2,
                                      labelStyle: GaugeTextStyle(color: Colors.white),
                                    ),
                                    GaugeRange(startValue: 6,endValue: 8,color: Colors.redAccent,startWidth: 2,endWidth: 2)],
                                  // GaugeRange(startValue: 100,endValue: 150,color: Colors.red,startWidth: 10,endWidth: 10)],
                                  pointers: <GaugePointer>[NeedlePointer(
                                    enableAnimation: true,
                                    animationDuration: 300,

                                    value:dataProvider.hasRide_started ? ((dataProvider.dataList.last.voltage*dataProvider.dataList.last.current1)/1000) : 0,
                                    needleStartWidth: 2.5,
                                    needleEndWidth: 2.5,
                                    needleLength: 0.92,
                                    needleColor: Colors.white70,
                                    knobStyle: KnobStyle(
                                        knobRadius: 0.58,
                                        color: Colors.black87

                                    ),
                                  )],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                        widget: Container(child:
                                        Text('POWER (kW)',style: TextStyle(fontSize: 13,fontWeight:FontWeight.bold,color: Colors.white54))
                                        ),
                                        angle: 90,positionFactor: 0.8)]
                              ),
                              RadialAxis(
                                radiusFactor: 0.58,
                                showLabels: false,
                                showTicks: false,
                                ranges: <GaugeRange>[
                                  GaugeRange(startValue: 0, endValue: 150,startWidth: 10,endWidth: 10,color: Colors.grey.shade700.withOpacity(0.2),)
                                ],
                              )
                            ]
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          clipBehavior: Clip.none,
                          width: MediaQuery.of(context).size.width*0.345,
                          height: MediaQuery.of(context).size.height*0.345,
                          // child: PowerChart(YaxisTitle: 'Torque',Legend: 'Torque',),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            shape: BoxShape.circle,
                          ),
                          child: dataProvider.hasRide_started? PowerPlot() : Text(''),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width*1.0,
                      height: 50,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:[
                            Center(
                              child: Wrap(
                                spacing: 5.0,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                          top:BorderSide(
                                            color: Colors.grey.shade700,
                                            width: 2.5,
                                          ),
                                          right: BorderSide(
                                            color: Colors.grey.shade700,
                                            width: 2.5,
                                          )
                                      ),
                                    ),
                                    width: 20,
                                    height: 30,
                                  ),
                                  Stack(
                                      children: [
                                        TemperatureSensor(
                                            temperature: dataProvider.hasRide_started? dataProvider.dataList.last.motor_temp : 0 ),
                                        Positioned(
                                            bottom: 0.5,
                                            left: 11,
                                            child: Text('Motor Temp.',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            )
                                        )
                                      ]
                                  ),
                                  Container(
                                    width: 20,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top:BorderSide(
                                          color: Colors.grey.shade700,
                                          width: 2.5,
                                        ),
                                        left: BorderSide(
                                          color: Colors.grey.shade700,
                                          width: 2.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Wrap(
                                spacing: 5.0,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                          top:BorderSide(
                                            color: Colors.grey.shade700,
                                            width: 2.5,
                                          ),
                                          right: BorderSide(
                                            color: Colors.grey.shade700,
                                            width: 2.5,
                                          )
                                      ),
                                    ),
                                    width: 20,
                                    height: 30,
                                  ),
                                  Stack(
                                      children: [
                                        TemperatureSensor(
                                            temperature: dataProvider.hasRide_started? dataProvider.dataList.last.controller_temp : 0 ),
                                        Positioned(
                                            bottom: 0.5,
                                            left: 4,
                                            child: Text('Controller Temp.',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            )
                                        )
                                      ]
                                  ),
                                  Container(
                                    width: 20,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top:BorderSide(
                                          color: Colors.grey.shade700,
                                          width: 2.5,
                                        ),
                                        left: BorderSide(
                                          color: Colors.grey.shade700,
                                          width: 2.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 50),
            color: Colors.black87,
            width: MediaQuery.of(context).size.width*0.16,
            // child: Text(formattedTime,textAlign: TextAlign.center,style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.white70),),
            child:
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: double.infinity,
                    height: 40,
                    child: Clock(),
                  ),
                  FilledButton(
                    onPressed: (){
                      if(dataProvider.hasRide_started==true) {
                        dataProvider.StopRide();
                        dataProvider.ShowNvabar();

                      }
                      else {
                        dataProvider.StartRide();
                        dataProvider.hideNavbar();
                      }
                    },
                    child:Text(dataProvider.hasRide_started ? 'Stop Ride' : 'Start Ride'),
                  ),
                  dataProvider.hasRide_started ? Text('')
                      :
                  FilledButton(
                      onPressed: (){
                        dataProvider.createExcelFile();
                      },
                      child: Text('Log Data')),

                  Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    width: double.infinity,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Transform.rotate(
                          angle: -math.pi / 15,
                          child: Container(
                            width: 3,
                            height: 40,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        Center(
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Noida',style: TextStyle(color: Colors.white70),),
                              Text('Sec 63 A',style: TextStyle(color: Colors.white70),),
                            ],
                          ),
                        ),
                        Transform.rotate(
                          angle: math.pi / 15,
                          child: Container(
                            width: 3,
                            height: 40,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Stack(
              children:[
                Container(
                  width: MediaQuery.of(context).size.width*0.42,
                  color: Colors.black87,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.8,
                        child: Container(
                          margin: EdgeInsets.only(top: 30,left: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.lightBlue,
                              width: 4.0,
                            ),
                          ),
                          child: SfRadialGauge(
                              backgroundColor: Colors.black87,
                              enableLoadingAnimation: true,
                              animationDuration: 1000,
                              axes: <RadialAxis>[
                                RadialAxis(
                                    radiusFactor: 1,
                                    minimum: 0 ,maximum: 150,
                                    ticksPosition: ElementsPosition.outside,
                                    minorTicksPerInterval: 20,
                                    minorTickStyle: MinorTickStyle(color: Colors.white54,length: 3),
                                    majorTickStyle: MajorTickStyle(color: Colors.white70),
                                    axisLabelStyle: GaugeTextStyle(
                                        color: Colors.white70,
                                        fontSize: 10,
                                        fontFamily: 'Times',
                                        fontStyle: FontStyle.italic
                                    ),
                                    labelOffset: 2,
                                    ranges: <GaugeRange>[
                                      GaugeRange(
                                        startValue: 0,endValue: 100,color: Colors.green,startWidth: 2,endWidth: 2,
                                        labelStyle: GaugeTextStyle(color: Colors.white),
                                      ),
                                      GaugeRange(startValue: 100,endValue: 150,color: Colors.lightBlueAccent,startWidth: 2,endWidth: 2)],
                                    // GaugeRange(startValue: 100,endValue: 150,color: Colors.red,startWidth: 10,endWidth: 10)],
                                    pointers: <GaugePointer>[NeedlePointer(
                                      enableAnimation: true,
                                      animationDuration: 500,
                                      value:dataProvider.hasRide_started ?kmhvalue :0,
                                      onValueChanging:(ValueChangingArgs args) {
                                        setState(() {
                                          if (args.value > 150) {
                                            args.cancel = false;
                                          }
                                        });
                                      },
                                      onValueChanged: (double newValue) {
                                        setState(() {
                                          double newValue=dataProvider.dataList.last.rpm;
                                          kmhvalue=newValue;
                                        });
                                      },
                                      needleStartWidth: 2.5,
                                      needleEndWidth: 2.5,
                                      needleLength: 0.92,
                                      needleColor: Colors.white70,
                                      knobStyle: KnobStyle(
                                          knobRadius: 0.52,
                                          color: Colors.black
                                      ),
                                    )],
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                          widget: Container(child:
                                          Column(
                                            children: [
                                              Text('${dataProvider.hasRide_started ?kmhvalue.toInt():0}',style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold,color: Colors.white)),
                                              Text('Km/h',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.white70),)
                                            ],
                                          )),
                                          angle: 90,positionFactor: 0.9)]
                                ),
                                RadialAxis(
                                  radiusFactor: 0.58,
                                  showLabels: false,
                                  showTicks: true,
                                  majorTickStyle: MajorTickStyle(color: Colors.white70),
                                  minorTicksPerInterval: 0,
                                  ranges: <GaugeRange>[
                                    GaugeRange(startValue: 0, endValue: 150,startWidth: 10,endWidth: 10,color: Colors.grey.shade700.withOpacity(0.2),)
                                  ],
                                )
                              ]
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20,left: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              //Battery Indicator Container
                              child: Container(
                                width: 80,
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 49,
                                        height: 25,
                                        padding: EdgeInsets.all(2.0),
                                        margin: EdgeInsets.only(right: 1),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade800,
                                            borderRadius: BorderRadius.circular(1)
                                        ),
                                        //Batter Level Container
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 26,
                                              margin: EdgeInsets.only(right: 1.5),
                                              width: 3,
                                              color: Colors.greenAccent,
                                            ),
                                            Container(
                                              height: 26,
                                              margin: EdgeInsets.only(right: 1.5),
                                              width: 3,
                                              color: Colors.greenAccent,
                                            ),
                                            Container(
                                              height: 26,
                                              margin: EdgeInsets.only(right: 1.5),
                                              width: 3,
                                              color: Colors.greenAccent,
                                            ),
                                            Container(
                                              height: 26,
                                              margin: EdgeInsets.only(right: 1.5),
                                              width: 3,
                                              color: Colors.greenAccent,
                                            ),
                                            Container(
                                              height: 26,
                                              margin: EdgeInsets.only(right: 1.5),
                                              width: 3,
                                              color: Colors.greenAccent,
                                            ),
                                            Container(
                                              height: 26,
                                              margin: EdgeInsets.only(right: 1.5),
                                              width: 3,
                                              color: Colors.greenAccent,
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        width: 2,
                                        height: 14,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 20,
                  child: Container(
                    height: 90,
                    width: 90,

                    child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(
                              majorTickStyle: MajorTickStyle(color: Colors.white,length: 4,),
                              maximumLabels: 10,
                              tickOffset: -4,
                              showLabels: false,
                              labelsPosition: ElementsPosition.outside,

                              minimum: 0, maximum: 10,
                              ranges: <GaugeRange>[
                                GaugeRange(startValue: 0, endValue: 10, color:Colors.grey.shade800,startWidth: 7,endWidth: 7,),
                              ],
                              // pointers: <GaugePointer>[
                              //   NeedlePointer(value: 5)],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(

                                    widget: Container(child:
                                    Column(
                                      children: [
                                        Text('${dataProvider.hasRide_started ? dataProvider.dataList.last.rpm.toInt()/10 : 0}',style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                                        SizedBox(height: 1,),
                                        Text('×100',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 12),),
                                        Text('RPM',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 12),)
                                      ],
                                    )),
                                    angle: 90, positionFactor: 0.8
                                )]
                          )]),
                  ),
                )
              ]

          ),
        ],
      ),
    ),
      onWillPop: () async {
        // Handle back button press
        // Navigate to a specific page (e.g., Homepage)
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
        // Return false to prevent default back button behavior
        return false;
      },


    )
      ;


  }




   void _SpeedData(Timer timer) {
     setState(() {
       speed.add((math.Random().nextInt(40) + 40).toDouble());
     });
   }


   List<double> _getSpeed() {
     return <double>[
       40.0,
       90.0,
       80.0,
       10.0,
       50.0,
     ];
   }

}


class TemperatureSensor extends StatefulWidget {
  const TemperatureSensor({super.key,required this.temperature});

  final double temperature;

  @override
  State<TemperatureSensor> createState() => _TemperatureSensorState();
}

class _TemperatureSensorState extends State<TemperatureSensor> {

  late List<double> temp1;
  late List<double> temp2;

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider=Provider.of<DataProvider>(context);


    int redvalue= _RedValue(widget.temperature);
    int greenvalue=_GreenValue(widget.temperature);

    return Container(
          width: 70,
          height: 40,
          decoration: BoxDecoration(
            color:Color.fromRGBO(redvalue,greenvalue, 0, 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Text('${widget.temperature} °F',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900),)),
        );
  }


  int _RedValue(double temp) {

    int red=0;
    if (temp>=85) {
      red=255;
    }
    else {
      red=temp.toInt()*3;
    }
    return red;
  }

  int _GreenValue(double temp) {

    int green;
    if (temp>=85) {
      green=0;
    }
    else {
      green=255 - (temp.toInt()*3);
    }
    return green;
  }
}



