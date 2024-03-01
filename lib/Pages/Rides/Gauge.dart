import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';



class SpeedoMeter extends StatelessWidget {
  const SpeedoMeter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.transparent,
      body: Center(
        child: Container(
          width: 550,
          height: 440,
          margin: EdgeInsets.only(top: 30),

          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child:SfRadialGauge(

            enableLoadingAnimation: true,
            animationDuration: 3500,

            axes:<RadialAxis> [
              RadialAxis(

                startAngle: 150,
                endAngle: 400,


                majorTickStyle: MajorTickStyle(color: Colors.white70),
                minorTickStyle: MinorTickStyle(color: Colors.white54,length: 2),
                labelsPosition: ElementsPosition.outside,
                axisLabelStyle: GaugeTextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontFamily: 'Times',
                  fontStyle: FontStyle.italic
                ),
                minorTicksPerInterval: 5,
                ticksPosition: ElementsPosition.outside,
                tickOffset: 15,


                minimum: 0,
                maximum: 200,
                ranges:<GaugeRange> [
                  GaugeRange(startValue: 0, endValue: 50, color:Colors.green,startWidth: 5,endWidth: 10,
                    gradient: const SweepGradient(
                        colors: <Color>[Colors.green, Colors.lightGreen],
                        stops: <double>[0.25, 0.75]),
                  ),
                  GaugeRange(startValue: 50,endValue: 120,color: Colors.orange,startWidth: 10,endWidth: 20,
                    gradient: const SweepGradient(
                        colors: <Color>[Colors.lightGreen, Colors.yellow],
                        stops: <double>[0.15, 0.75]),
                  ),

                  GaugeRange(startValue: 120,endValue: 200,color: Colors.red,startWidth: 20,endWidth: 30,
                    gradient: const SweepGradient(
                        colors: <Color>[Colors.redAccent, Colors.red],
                        stops: <double>[0.25, 0.75]),

                  )
                ],
                 pointers: <GaugePointer>[
                   RangePointer(value: 65,pointerOffset: 20,width: 1,),
                   NeedlePointer(value: 65,
                     needleColor: Colors.white,
                     enableAnimation: true,
                     needleLength: 0.5,
                     knobStyle: KnobStyle(
                         knobRadius: 0.08,
                         sizeUnit: GaugeSizeUnit.factor,
                         color: Colors.black),
                     tailStyle: TailStyle(length: 0.13, width: 8,
                       gradient:LinearGradient(
                           colors: <Color>[
                             Color(0xFFFF6B78), Color(0xFFFF6B78),
                             Color(0xFFE20A22), Color(0xFFE20A22)],
                           stops: <double>[0, 0.5, 0.5, 1]),
                     ),
                     gradient: const LinearGradient(
                         colors: <Color>[
                           Color(0xFFFF6B78), Color(0xFFFF6B78),
                           Color(0xFFE20A22), Color(0xFFE20A22)],
                         stops: <double>[0, 0.5, 0.5, 1]),





                   )],
                 annotations: <GaugeAnnotation>[
                   GaugeAnnotation(widget: Container(child:
                   Text('65.0',style: TextStyle(fontSize: 33,fontWeight: FontWeight.bold,color: Colors.white70,fontStyle: FontStyle.italic))),
                     angle: 90, positionFactor: 0.5)
                 ],

              )
            ],
          )
        )
      ),
    );
  }
}