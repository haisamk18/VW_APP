import 'package:flutter/material.dart';
import 'Databasehelper.dart'; // Import your database helper class
import 'ExcelClass.dart'; // Import your ExcelData class

class DataDisplayPage extends StatefulWidget {
  @override
  _DataDisplayPageState createState() => _DataDisplayPageState();
}

class _DataDisplayPageState extends State<DataDisplayPage> {
  late Future<List<ExcelData>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = DatabaseHelper().getAllExcelData();
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
