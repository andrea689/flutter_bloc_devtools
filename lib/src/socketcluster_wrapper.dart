part of flutter_bloc_devtools;

class SocketClusterWrapper {
  Socket? _socket;
  Function socketFactory;
  String url;
  SocketClusterWrapper(this.url, {this.socketFactory = Socket.connect});

  Future<void> connect() async {
    _socket = await socketFactory(url);
  }

  Emitter on(String event, Function func) {
    return _socket!.on(event, func);
  }

  void emit(String event, Object data, [AckCall? ack]) {
    _socket!.emit(event, data, ack);
  }

  String? get id => _socket!.id;
}
