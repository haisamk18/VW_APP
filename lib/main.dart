import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vw_app/Pages/Controlller/Blcserial.dart';
import 'package:vw_app/Bluetoothprovider.dart';
import 'package:vw_app/Pages/Phone.dart';
import 'package:vw_app/Pages/splashscreen.dart';
import 'package:vw_app/Pages/splashscrn.dart';
import 'package:vw_app/Pages/Rides/PowerNew.dart';

import 'Pages/OtpVerify.dart';


//import 'package:vw_app/Pages/Controlller/Nbls.dart';


void main() {
  runApp(


    ChangeNotifierProvider(
        create: (context)=> DataProvider(),
        child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);


    return
       MaterialApp(


        title: 'Forciti',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
      
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent.shade400),
          useMaterial3: true,
        ),
         initialRoute: 'phone',

         routes: {
           'phone': (context) => MyPhone(),
           'verify': (context) => MyVerify()
         },

      );

  }
}


