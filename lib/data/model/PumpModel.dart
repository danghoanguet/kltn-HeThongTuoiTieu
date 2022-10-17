class PumpModel {
  final String control;
  final String state;

  PumpModel({
    required this.control,
    required this.state,
  });

  factory PumpModel.fromRTDB(Map<String, dynamic> data) {
    return PumpModel(
      control: data['Manual'] ?? "",
      state: data['State'] ?? "",
    );
  }
}
