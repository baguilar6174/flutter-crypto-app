import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:crypto_app/features/features.dart';

class WsRepositoryImpl implements WsRepository {
  WsRepositoryImpl(this.builder);

  final WebSocketChannel Function(List<String>) builder;
  WebSocketChannel? _channel;

  @override
  Future<bool> connect(List<String> ids) async {
    try {
      _channel = builder(ids);
      await _channel!.ready;
      return true;
    } catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
  }

  @override
  Future<void> disconnect() async {
    await _channel?.sink.close();
    _channel = null;
  }
}
