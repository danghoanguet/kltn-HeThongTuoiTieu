class ThresholdModel {
  final String temp;
  final String humid;
  final String soil;

  ThresholdModel({
    required this.temp,
    required this.humid,
    required this.soil,
  });

  factory ThresholdModel.fromRTDB(Map<String, dynamic> data) {
    return ThresholdModel(
      temp: data['TEMP'] ?? "",
      humid: data['HUM'] ?? "",
      soil: data['SOIL'] ?? "",
    );
  }
}
