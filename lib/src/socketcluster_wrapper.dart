part of flutter_bloc_devtools;

class SocketClusterWrapper {
  socket_cc.Socket _socket;
  Function socketFactory;
  String url;

  SocketClusterWrapper(this.url,
      {this.socketFactory = socket_cc.Socket.connect});

  Future<void> connect() async {
    _socket = await socketFactory(url);
  }

  socket_cc.Emitter on(String event, Function func) {
    return _socket.on(event, func);
  }

  void emit(String event, Object data, [socket_cc.AckCall ack]) {
    _socket.emit(event, data, ack);
  }

  String get id => _socket.id;
}
