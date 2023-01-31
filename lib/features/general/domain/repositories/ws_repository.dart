abstract class WsRepository {
  Future<bool> connect(List<String> ids);
  Future<void> disconnect();
}
