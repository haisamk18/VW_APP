import 'package:flutter/material.dart';

class Inputs extends StatefulWidget {
  const Inputs({super.key});

  @override
  State<Inputs> createState() => _InputsState();
}

class _InputsState extends State<Inputs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(backgroundColor:Colors.black87,isExtended:true,onPressed: (){},child: Text('Submit',style: TextStyle(color: Colors.white70),),mouseCursor: MaterialStateMouseCursor.clickable,elevation: 20,),
      backgroundColor: Colors.black87,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height*0.7,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: TextField(
                      style: TextStyle(color: Colors.white70),
                      decoration: InputDecoration(

                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder(),
                        hintText: 'Enter Tyre Dia.',
                        hintStyle: TextStyle(color: Colors.white24)
                      ),
                    ),
                  ),
                  Center(

                    child: TextField(
                      style: TextStyle(color: Colors.white70),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder(),
                        hintText: 'Enter Gear Ratio',
                          hintStyle: TextStyle(color: Colors.white24)
                      ),
                    ),
                  ),
                  Center(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder(),
                        hintText: 'Enter a Variable',
                          hintStyle: TextStyle(color: Colors.white24)
                      ),
                    ),
                  ),
                  Center(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder(),
                        hintText: 'Enter a variable',
                          hintStyle: TextStyle(color: Colors.white24)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
