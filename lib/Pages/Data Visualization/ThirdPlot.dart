import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Bluetoothprovider.dart';

//Speed Vs TIME Plot


class ThirdPlot extends StatefulWidget {
  const ThirdPlot({super.key});

  @override
  State<ThirdPlot> createState() => _FirstPlotState();
}

class _FirstPlotState extends State<ThirdPlot> {

  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;

  @override
  void initState() {
    chartData=getInitialChartData();
    Timer.periodic(Duration(milliseconds: 300),updateDataSource);
   // Timer.periodic(const Duration(milliseconds: 300), updateDataSource);
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
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

    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Container(
                margin: EdgeInsets.all(30.0),
                child: SfCartesianChart(
                    legend: Legend(
                        isVisible: true,
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

                    ),
                    plotAreaBorderWidth: 0.0,
                    //  plotAreaBackgroundImage: const AssetImage('assets/images/vwlogowin.png'),
                    title: ChartTitle(text: 'Speed vs Time',textStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white70,fontSize: 10)),
                    tooltipBehavior: TooltipBehavior(enable: true,animationDuration: 0,duration: 1000),
                    series: <CartesianSeries>[
                      // Renders line chart
                      LineSeries<LiveData, int>(
                        legendItemText: 'Speed (km/h)',

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
                )
            )
        )
    );
  }

  /*
  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, (math.Random().nextInt(60) + 50)));

    chartData.removeAt(0);

    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);

  }

   */


  int time=19;
  void updateDataSource(Timer timer) {
    DataProvider dataProvider = Provider.of<DataProvider>(context, listen: false);
    double blcurrvalue=dataProvider.dataList.last.rpm;
    double factor=0.1885*0.62;
    double kmhvalue=blcurrvalue*factor;
    if (chartData.length >= 19) {
      chartData.removeAt(0);
      chartData.add(LiveData(time++, kmhvalue));
    }
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);

    setState(() {

    }); // Trigger rebuild
  }

  List<LiveData> getInitialChartData() {
    return List.generate(19, (index) => LiveData(index, 0)); // Initial chart data with power = 0
  }

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


