abstract class WsRepository {
  Future<bool> connect(List<String> ids);
  Stream<Map<String, double>> get onPricesChanged;
  Future<void> disconnect();
}
