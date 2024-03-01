import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Bluetoothprovider.dart';


//Power vs Speed;


class FirstPlot extends StatefulWidget {
   FirstPlot({super.key});

  //final List<LiveData> data=[];


  @override
  State<FirstPlot> createState() => _FirstPlotState();
}

class _FirstPlotState extends State<FirstPlot> {
  late List<ChartData> chartData;
  late ChartSeriesController _chartSeriesController;

  @override
  void initState() {
    chartData = _getData();
    Timer.periodic(const Duration(milliseconds: 300), updateDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.all(30.0),
        child: Center(
            child: Container(
                child: SfCartesianChart(
                  enableAxisAnimation: true,
                  zoomPanBehavior: ZoomPanBehavior(enableMouseWheelZooming: true,enablePanning: true),
                  title: ChartTitle(text: 'Power vs Speed',textStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white70,fontSize: 10)),
                    primaryXAxis: NumericAxis(
                        title: AxisTitle(
                            text: 'Speed',
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w300
                            )
                        ),
                    ),
                    primaryYAxis: NumericAxis(
                      title: AxisTitle(
                          text: 'Power',
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w300
                          )
                      ),
                      labelRotation: -30,
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true,animationDuration: 0,duration: 1000),
                    plotAreaBorderWidth: 0,
                    borderWidth: 0,
                    borderColor: Colors.black,
                    plotAreaBorderColor: Colors.black,
                    backgroundColor: Colors.black,
                    onDataLabelTapped: (DataLabelTapDetails args) {
                      print(args.seriesIndex);
                    },
                    plotAreaBackgroundColor: Colors.black,
                    series: <CartesianSeries>[
                      // Renders scatter chart
                      ScatterSeries<ChartData,int>(
                          animationDuration: 1000,
                          borderWidth: 0,
                          color: Colors.blueAccent,
                          onRendererCreated: (ChartSeriesController controller) {
                            _chartSeriesController = controller;
                          },
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.time,
                          yValueMapper: (ChartData data, _) => data.speed
                      ),
                    ]
                )
            )
        ),
      ),
    );
  }
  int time = 19;
  void updateDataSource(Timer timer) {
    DataProvider dataProvider=Provider.of<DataProvider>(context);
    chartData.add(ChartData(time++,dataProvider.dataList.last.voltage.toInt()));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);

  }
  List<ChartData> _getData() {
    return <ChartData>[
      ChartData(0, 12),
      ChartData(1, 14),
      ChartData(2, 40),
      ChartData(3, 46),
      ChartData(4, 50),
      ChartData(5, 32),
      ChartData(6, 19),
      ChartData(7, 28),
      ChartData(8, 46),
      ChartData(9, 9),
      ChartData(10, 26),
      ChartData(11, 38),
      ChartData(12, 17),
      ChartData(13, 87),
      ChartData(14, 65),
      ChartData(15, 21),
      ChartData(16, 65),
      ChartData(17, 21),
      ChartData(18, 60),
    ];
  }
}

class ChartData {
  final int time;
  final int speed;

  ChartData(this.time,this.speed);

}
class chartDataSecond {
  final int time;
  final int speed;

  chartDataSecond(this.time,this.speed);
}

