import 'package:flutter/material.dart';

import 'Databasehelper.dart';
import 'ExcelClass.dart';

 // Import your ExcelData class

class DataDisplayPage extends StatefulWidget {
  @override
  _DataDisplayPageState createState() => _DataDisplayPageState();
}

class _DataDisplayPageState extends State<DataDisplayPage> {
  late Future<List<ExcelData>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _getData();
  }

  Future<List<ExcelData>> _getData() async {
    return [
      ExcelData(10, 20),
      ExcelData(20, 30),
      ExcelData(30, 40),
      ExcelData(40, 50),
      ExcelData(50, 60),
      ExcelData(60, 70),
      ExcelData(70, 80),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Display'),
      ),
      body: FutureBuilder<List<ExcelData>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data ?? [];
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(
                  title: Text('First Value: ${item.first}, Second Value: ${item.second}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
