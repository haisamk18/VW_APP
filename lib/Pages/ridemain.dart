import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vw_app/Pages/Rides/Ride.dart';
import 'package:vw_app/Pages/Start_ride.dart';

import '../Bluetoothprovider.dart';


class RideMain extends StatefulWidget {
  const RideMain({super.key});

  @override
  State<RideMain> createState() => _RideMainState();
}

class _RideMainState extends State<RideMain> {
  final controller=PageController(initialPage: 0);

  @override
  void initState() {

    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

  }
  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider=Provider.of<DataProvider>(context);
    return dataProvider.hasRide_started ? Ride() : Start_Ride();
  /*  return  dataProvider.isConnected ?
    Scaffold(

      backgroundColor: Colors.black87,
      body: Center(
        child: PageView( controller: controller,
          children: const <Widget>[
                  Ride(),
          ],
        )
      ),
    ):
    Scaffold(
        backgroundColor: Colors.black87,
        body: dataProvider.isConnected
            ?
        Container(
          child: Center(
            child: Text('Fetching Data....',style: TextStyle(color: Colors.white70),),
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
    ); */
  }
}