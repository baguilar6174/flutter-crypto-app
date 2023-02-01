import 'package:freezed_annotation/freezed_annotation.dart';

part 'ws_status.freezed.dart';

@freezed
class WsStatus with _$WsStatus {
  const factory WsStatus.connecting() = ConnectingWsStatus;
  const factory WsStatus.connected() = ConnectedWsStatus;
  const factory WsStatus.error() = ErrorWsStatus;
}
