class WifiModel {
  final String wifiName;
  final String wifiPassword;
  final String wifiIpAddress;
  final String wifiStatus;

  WifiModel(
      {required this.wifiName,
      required this.wifiPassword,
      required this.wifiIpAddress,
      required this.wifiStatus});

  factory WifiModel.fromRTDB(Map<String, dynamic> data) {
    return WifiModel(
        wifiName: data['Name'] ?? "",
        wifiPassword: data['Password'] ?? "",
        wifiIpAddress: data['IP'] ?? "",
        wifiStatus: data['Status'] ?? "Disconnected");
  }
}
