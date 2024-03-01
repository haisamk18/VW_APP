import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Bluetoothprovider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider=Provider.of<DataProvider>(context);
    return Container(
      child:Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bikenew.png'),
                  fit: BoxFit.contain
                ),
                color: Colors.black
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15,top: 20),
              height: MediaQuery.of(context).size.height*0.25,
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Forciti is',style: TextStyle(color: Colors.blueAccent.shade400,fontSize: 24,fontWeight: FontWeight.w900),),
                  Text('unlocked and ready.',style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w900),)
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.25,
              padding: EdgeInsets.only(left: 15,top: 0),
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dataProvider.isConnected? 'Bluetooth Module is Connected' :'Bluetooth is not Connected',style: TextStyle(color: Colors.white70,fontSize: 18,fontWeight: FontWeight.w500,),),
                  dataProvider.isConnected ? Text('Enjoy the Ride',style: TextStyle(color: Colors.blueAccent.shade400,fontWeight: FontWeight.w700),) :
                  InkWell(child: Text('Connect again',style: TextStyle(color: Colors.white70,fontSize: 14,fontWeight: FontWeight.w900),),onTap: (){dataProvider.connectToDevice();},)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
