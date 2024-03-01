import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vw_app/Pages/Phone.dart';

import '../Bluetoothprovider.dart';

class Settings extends StatelessWidget {
  const
  Settings({super.key});

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider=Provider.of<DataProvider>(context);

    return Scaffold(

      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children:[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(dataProvider.isConnected? 'Device is Connected..':'Device is not Connected',style: TextStyle(color: Colors.white),),
                      SizedBox(height: 10,),
                      dataProvider.isConnected ?
                      FilledButton(onPressed: (){dataProvider.disconnect();}, child: Text('Disconnect'))
                          :
                      FilledButton(onPressed: (){dataProvider.connectToDevice();}, child: Text('Connect again.'))

                    ],
                  ),
                ),
                Container(),

              ],
            ),
          ),
          Positioned(
            top: 80,
            right: 20,
            child: InkWell(
              onTap: () {
                dataProvider.disconnect();
                Navigator.pushReplacementNamed(context, 'phone');
              },
              child: Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(

                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border(
                    top: BorderSide(color: Colors.grey,width: 1),
                    bottom: BorderSide(color: Colors.grey,width: 1),
                    left: BorderSide(color: Colors.grey,width: 1),
                    right: BorderSide(color: Colors.grey,width: 1),
                  )

                ),
                width: 100,
                height: 40,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Log Out',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    Image.asset('assets/images/logout.png')
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            child: Center(child: Text('Settings',style: TextStyle(color: Colors.white70,fontSize: 16,fontWeight: FontWeight.bold),)),
          )
        ]

      ),
    );
  }
}
