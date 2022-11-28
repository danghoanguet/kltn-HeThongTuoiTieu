class Pump {
  final String year;
  final String month;
  final String day;
  final String id;

  Pump(
      {required this.year,
      required this.month,
      required this.day,
      required this.id});

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'month': month,
      'day': day,
      'id': id,
    };
  }

  factory Pump.fromMap(Map<String, dynamic> data, String documentId) {
    final String year = data['year'] ?? "";
    final String month = data['month'] ?? "";
    final String day = data['day'] ?? "";
    final String id = data['id'] ?? "";

    return Pump(year: year, month: month, day: day, id: id);
  }

  fromMap(Map<String, dynamic> data, String documentId) { final String year = data['year'];
  final String month = data['month'] ?? "";
  final String day = data['day'] ?? "";
  final String id = data['id'] ?? "";

  return Pump(year: year, month: month, day: day, id: id);}
}
