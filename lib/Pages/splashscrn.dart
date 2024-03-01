import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:vw_app/Pages/homepage.dart';
import 'package:vw_app/Pages/Rides/Gauge.dart';
import 'package:vw_app/Pages/ridemain.dart';

class Splashscrn extends StatelessWidget {
  const Splashscrn({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
          builder: (context,orientation) {
            return Scaffold(
              appBar: null,
              backgroundColor: Colors.black87,
              body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child:Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Logo

                        Container(
                          width: 100.0,
                          height: MediaQuery.of(context).size.height*0.3,


                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.lightBlue,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade600,
                                    spreadRadius: 0.5,
                                    blurRadius: 10
                                )
                              ]


                          ),
                          child: Image.asset('assets/images/vwlogo.jpeg'),
                        ),
                        SizedBox(height: 20.0,),
                        Text(

                          'Welcome to VoltWorks...',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white38,
                            decoration: TextDecoration.none,
                            fontStyle: FontStyle.italic,

                          ),
                        ).animate().slide(),

                        //Buttons

                        Container(
                          height: MediaQuery.of(context).size.height*0.3,
                         // padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 44.0,
                                width: 145.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                        colors: [Color.fromARGB(255, 2, 173, 102), Colors.blue]),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade600,
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ).scale(1)
                                    ]
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => RideMain())
                                    );
                                  },


                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: Text(
                                    "Ride",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,


                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 44.0,
                                width: 145.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                        colors: [Color.fromARGB(255, 2, 173, 102), Colors.blue]),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade600,
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ).scale(1)
                                    ]
                                ),

                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MyHomePage())
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: Text(
                                    "Stats for nerds",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),

                                  ),
                                ),
                              )
                            ],

                          ),

                        )




                      ],
                    ),
                  )

              ),



            );

          },


         );

  }
}



