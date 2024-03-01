import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Bluetoothprovider.dart';

//Time,Speed,Temperature vs Time Plot


class SecondPlot extends StatefulWidget {
  SecondPlot({super.key});

  //final List<dataviz.LiveData> data=[];
  @override
  State<SecondPlot> createState() => _SecondPlotState();
}

class _SecondPlotState extends State<SecondPlot> {

  late List<LiveData> chartData;
  late List<LiveData> chartDatasecond;
  late List<LiveData> chartDataThird;
  late ChartSeriesController _chartSeriesController;
  late ChartSeriesController _chartSeriesControllersecond;
  late ChartSeriesController _chartSeriesControllerthird;



  @override
  void initState() {
    chartData = getInitialChartData();
    chartDatasecond = getInitialChartDatasecond();
    chartDataThird = getInitialChartDatathird();
    Timer.periodic(const Duration(milliseconds: 300), updateDataSource);
    super.initState();
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

                    tooltipBehavior: TooltipBehavior(enable: true,animationDuration: 0,duration: 1000),
                    series: <CartesianSeries>[
                      // Renders line chart
                    LineSeries<LiveData, int>(
                          legendItemText: 'Speed',

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
                      LineSeries<LiveData, int>(
                        legendItemText: 'Temperature',
                        color: Colors.red,
                        emptyPointSettings: const EmptyPointSettings(
                          mode:EmptyPointMode.average,
                        ),
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesControllersecond = controller;
                        },


                        dataSource: chartDatasecond,
                        xValueMapper: (LiveData data, _) => data.time,
                        yValueMapper: (LiveData data, _) => data.speed,

                      ),
                      LineSeries<LiveData, int>(
                        legendItemText: 'Current',
                        color: Colors.greenAccent,
                        emptyPointSettings: const EmptyPointSettings(
                          mode:EmptyPointMode.average,
                        ),
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesControllerthird = controller;
                        },


                        dataSource: chartDataThird,
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
    DataProvider dataProvider=Provider.of<DataProvider>(context);
    chartData.add(LiveData(time++, (math.Random().nextInt(60) + 50)));
    chartDatasecond.add(LiveData(time++, dataProvider.dataList.last.rpm));
    chartDataThird.add(LiveData(time++, dataProvider.dataList.last.current1));
    chartData.removeAt(0);
    chartDatasecond.removeAt(0);
    chartDataThird.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
    _chartSeriesControllersecond.updateDataSource(
        addedDataIndex: chartDatasecond.length - 1, removedDataIndex: 0);
    _chartSeriesControllerthird.updateDataSource(
        addedDataIndex: chartDataThird.length - 1, removedDataIndex: 0);

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
      chartDatasecond.add(LiveData(time++, dataProvider.dataList.last.motor_temp));
      chartDataThird.add(LiveData(time++, dataProvider.dataList.last.current1));
    }
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0
    );
    _chartSeriesControllersecond.updateDataSource(
        addedDataIndex: chartDatasecond.length - 1, removedDataIndex: 0
    );
    _chartSeriesControllerthird.updateDataSource(
        addedDataIndex: chartDataThird.length - 1, removedDataIndex: 0
    );


    setState(() {

    }); // Trigger rebuild
  }

  List<LiveData> getInitialChartData() {
    return List.generate(19, (index) => LiveData(index, 0)); // Initial chart data with power = 0
  }
  List<LiveData> getInitialChartDatasecond() {
    return List.generate(19, (index) => LiveData(index, 0)); // Initial chart data with power = 0
  }
  List<LiveData> getInitialChartDatathird() {
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

  List<LiveData> getChartDatasecond() {
    return <LiveData>[
      LiveData(0, 10),
      LiveData(1, 8),
      LiveData(2, 4),
      LiveData(3, 62),
      LiveData(4, 11),
      LiveData(5, 28),
      LiveData(6, 90),
      LiveData(7, 21),
      LiveData(8, 7),
      LiveData(9, 1),
      LiveData(10, 75),
      LiveData(11, 22),
      LiveData(12, 40),
      LiveData(13, 22),
      LiveData(14, 65),
      LiveData(15, 15),
      LiveData(16, 22),
      LiveData(17, 98),
      LiveData(18, 11)
    ];
  }

  List<LiveData> getChartDataThird() {
    return <LiveData>[
      LiveData(0, 10),
      LiveData(1, 3),
      LiveData(2, 2),
      LiveData(3, 4),
      LiveData(4, 5),
      LiveData(5, 8),
      LiveData(6, 10),
      LiveData(7, 11),
      LiveData(8, 12),
      LiveData(9, 13),
      LiveData(10, 15),
      LiveData(11, 12),
      LiveData(12, 10),
      LiveData(13, 12),
      LiveData(14, 15),
      LiveData(15, 5),
      LiveData(16, 2),
      LiveData(17, 8),
      LiveData(18, 1)
    ];
  }
}

class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final num speed;
}
