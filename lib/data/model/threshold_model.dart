class ThresholdModel {
  final String temp;
  final String humid;
  final String soil;
  final String vpdMin;
  final String vpdMax;

  ThresholdModel({
    required this.vpdMin,
    required this.vpdMax,
    required this.temp,
    required this.humid,
    required this.soil,
  });

  factory ThresholdModel.fromRTDB(Map<String, dynamic> data) {
    return ThresholdModel(
      temp: data['TEMP'] ?? "",
      humid: data['HUM'] ?? "",
      soil: data['SOIL'] ?? "",
      vpdMin: data['vpdMin'] ?? "",
      vpdMax: data['vpdMax'] ?? "",
    );
  }
}
