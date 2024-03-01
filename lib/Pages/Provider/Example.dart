import 'package:flutter/cupertino.dart';

class Example extends ChangeNotifier {
  String text='';
  List<String> chartData=['Vw','New','MI','100','100','300','400','500'];
  @override

  void Changename()  {
    text='Voltworks';
    chartData.add('new');
    for (int i=0;i<7;i++){
      chartData.add('New Value ${i}');
    }
    notifyListeners();

 }
}