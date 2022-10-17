class DHTModel {
  final String temp;
  final String humid;
  final String soil;

  DHTModel({
    required this.temp,
    required this.humid,
    required this.soil,
  });

  factory DHTModel.fromRTDB(Map<String, dynamic> data) {
    return DHTModel(
      temp: data['Nhiệt Độ'] ?? "",
      humid: data['Độ Ẩm'] ?? "",
      soil: data['Độ Ẩm Đất'] ?? "",
    );
  }
}
