class Constants {
  Constants._();

  static Constants get = Constants._();

  bool isProd = true; // To change environment
  late String baseUrl =
      isProd ? "https://api.coincap.io/v2" : "https://api.coincap.io/v2";
  String appName = "Crypto App";
}
