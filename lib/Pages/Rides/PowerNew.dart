import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Bluetoothprovider.dart';


class PowerPlot extends StatefulWidget {
  const PowerPlot({super.key});

  @override
  State<PowerPlot> createState() => _FirstPlotState();
}

class _FirstPlotState extends State<PowerPlot> {
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;

  @override
  void initState() {
    //chartData = getChartData();
    chartData=getInitialChartData();
    Timer.periodic(Duration(milliseconds: 300),updateDataSource);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Timer.periodic(const Duration(milliseconds: 300), updateDataSource);

    DataProvider dataProvider=Provider.of<DataProvider>(context);
    final LinearGradient _linearGradient = LinearGradient(
      colors: <Color>[
        Colors.lightBlue.shade100,
        Colors.transparent

      ],
      stops: <double>[0.004, 0.6],
      // Setting alignment for the series gradient
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    );

    return dataProvider.hasRide_started?Center(
        child: Container(
            clipBehavior: Clip.hardEdge,
            width: 330.0,
            height: 330.0,
            decoration: BoxDecoration(shape: BoxShape.rectangle),

            child: CircleAvatar(
              radius: 300,
              backgroundColor: Colors.transparent,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    shape: BoxShape.circle
                ),
                width: 330.0,
                height: 330.0,
                child: SfCartesianChart(

                    legend: Legend(
                        isVisible: false,
                        textStyle: TextStyle(color: Colors.white70,fontSize: 12)
                    ),
                    primaryXAxis: NumericAxis(

                      title: AxisTitle(

                          text: 'Time',
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      isVisible:false,

                    ),
                    primaryYAxis: NumericAxis(isVisible: false,),
                    plotAreaBorderWidth: 0.0,
                    //  plotAreaBackgroundImage: const AssetImage('assets/images/vwlogowin.png'),
                    //title: ChartTitle(text: 'Speed vs Time',textStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white70,fontSize: 10)),

                    series: <CartesianSeries>[
                      // Renders line chart
                      SplineAreaSeries<LiveData, int>(
                        borderWidth: 1.0,

                        borderColor: Colors.lightBlue,
                        gradient:_linearGradient,

                        emptyPointSettings: const EmptyPointSettings(
                          mode:EmptyPointMode.average,
                        ),
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesController = controller;
                        },
                        dataSource: chartData,
                        xValueMapper: (LiveData data, _) => data.time,
                        yValueMapper: (LiveData data, _) => data.speed,

                      ),

                    ]
                ),
              ),
            )
        )
    ):Center();



  }
  int time=8;
  void updateDataSource(Timer timer) {
    DataProvider dataProvider = Provider.of<DataProvider>(context, listen: false);
    if (chartData.length >= 8) {
      chartData.removeAt(0);
      chartData.add(LiveData(time++, (dataProvider.dataList.last.voltage * dataProvider.dataList.last.current1)/1000));
    }
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);

    setState(() {

    }); // Trigger rebuild
  }

  List<LiveData> getInitialChartData() {
    return List.generate(8, (index) => LiveData(index, 0)); // Initial chart data with power = 0
  }


/*

  int time = 19;
   void updateDataSource(Timer timer) {
     //DataProvider dataProvider = Provider.of<DataProvider>(context);
     chartData.add(LiveData(time++, (math.Random().nextInt(60) + 50)));
     chartData.removeAt(0);
     _chartSeriesController.updateDataSource(
         addedDataIndex: chartData.length - 1, removedDataIndex: 0);

   }



 */

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 21),
      LiveData(1, 24),
      LiveData(2, 32),
      LiveData(3, 62),
      LiveData(4, 27),
      LiveData(5, 82),
      LiveData(6, 92),
      LiveData(7, 25),
      LiveData(8, 52),
      LiveData(9, 21),
      LiveData(10, 12),
      LiveData(11, 29),
      LiveData(12, 42),
      LiveData(13, 28),
      LiveData(14, 82),
      LiveData(15, 25),
      LiveData(16, 32),
      LiveData(17, 27),
      LiveData(18, 27)
    ];
  }
}


class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final num speed;
}

