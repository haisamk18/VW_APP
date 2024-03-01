import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vw_app/Pages/Controlller/Blcserial.dart';
import 'package:vw_app/Pages/Data%20Visualization/Datavizmain.dart';
import 'package:vw_app/Pages/Gridexample.dart';
import 'package:vw_app/Pages/Home.dart';
import 'package:vw_app/Pages/Rides/Ride.dart';
import 'package:vw_app/Pages/Settings.dart';
import 'package:vw_app/Pages/Start_ride.dart';
import 'package:vw_app/Pages/Stats_for_Nerds/Statsmain.dart';
import 'package:vw_app/Pages/Stats_for_Nerds/stats.dart';
import 'package:vw_app/Pages/Terminal/Terminal.dart';
import 'package:vw_app/Pages/ridemain.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:vw_app/Pages/splashscreen.dart';

import '../Bluetoothprovider.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> bottomBarPages = [
    const Home(),
    const Start_Ride(),
    const StatsMain(),
    const Settings(),

  ];

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider=Provider.of<DataProvider>(context);
    return Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
      extendBody: true,
      bottomNavigationBar:
      AnimatedNotchBottomBar(

        notchBottomBarController: _controller,
        color: Colors.blue,
        blurFilterX: 20.0,
        blurOpacity: 0.8,
        showBlurBottomBar: true,
        showShadow: true,
        showLabel: true,
        itemLabelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 9,),
        shadowElevation: 5,
        kBottomRadius: 20.0,
        removeMargins: false,
        bottomBarWidth: 500,
        durationInMilliSeconds: 200,
        bottomBarItems: [
          const BottomBarItem(
              inActiveItem: Icon(
              Icons.home_filled,
                color: Colors.white,
              ),
              activeItem: Icon(
                Icons.home_filled,
                color: Colors.blueAccent,
              ),
              itemLabel: 'Home',
            ),
           BottomBarItem(
            inActiveItem: Image.asset(
            'assets/images/drivewb.png',
            color: Colors.white,
            ),
            activeItem: Image.asset(
            'assets/images/drivewb.png',
            color: Colors.blueAccent,
            ),
            itemLabel: 'Ride',
            ),
          BottomBarItem(
            inActiveItem: Image.asset(
              'assets/images/datavizwb.png',
              color: Colors.white,
            ),
            activeItem: Image.asset(
              'assets/images/datavizwb.png',
              color: Colors.blueAccent,
            ),
            itemLabel: 'Stats',
          ),
          const BottomBarItem(
            inActiveItem: Icon(
            Icons.settings,
            color: Colors.white,
            ),
            activeItem: Icon(
            Icons.settings,
            color: Colors.blueAccent,
            ),
            itemLabel: 'Settings',
            ),
        ],
        onTap: (index) {
          /// perform action on tab change and to update pages you can update pages without pages
          // log('current selected index $index');
          _pageController.jumpToPage(index);
        },
        kIconSize: 23.0,
    ),
    );
  }
}