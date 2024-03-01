import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vw_app/Pages/Data%20Visualization/ThirdPlot.dart';
import 'package:vw_app/Pages/Stats_for_Nerds/GridNew.dart';
import 'package:vw_app/Pages/Stats_for_Nerds/stats.dart';

import '../../Bluetoothprovider.dart';

class StatsMain extends StatefulWidget {
  const StatsMain({super.key});

  @override
  State<StatsMain> createState() => _StatsMainState();
}

class _StatsMainState extends State<StatsMain> {
  final controller=PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider=Provider.of<DataProvider>(context);
    return Scaffold(
      body: Center(
        child: PageView(
          controller: controller,
          children: [

            Stats(),
            ThirdPlot()
          ],
        ),
      ),
    );
  }
}
