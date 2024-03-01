class ExcelData {
  int first;
  int second;

  ExcelData(this.first, this.second);

  Map<String, dynamic> toMap() {
    return {
      'first': first,
      'second': second,
    };
  }

  factory ExcelData.fromMap(Map<String, dynamic> map) {
    return ExcelData(
      map['first'],
      map['second'],
    );
  }
}
