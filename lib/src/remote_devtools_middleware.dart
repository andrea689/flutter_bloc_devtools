part of flutter_bloc_devtools;

/// The connection state of the middleware
enum RemoteDevToolsStatus {
  /// No socket connection to the remote host
  notConnected,

  /// Attempting to open socket
  connecting,

  /// Connected to remote, but not started
  connected,

  /// Awaiting start response
  starting,

  /// Sending and receiving actions
  started
}

abstract class Mappable {
  Map<String, dynamic> toMap();
}

class RemoteDevToolsObserver extends BlocObserver {
  ///
  /// The remote-devtools server to connect to. Should include
  /// protocol and port if necessary. For example:
  ///
  /// example.lan:8000
  ///
  final String _host;
  SocketClusterWrapper? socket;
  late String _channel;
  RemoteDevToolsStatus _status = RemoteDevToolsStatus.notConnected;
  RemoteDevToolsStatus get status => _status;

  final Map<String, Map<int, String>> _blocs = {};
  final Map<String?, dynamic> _appState = {};

  /// The name that will appear in Instance Name in Dev Tools. If not specified,
  /// default to 'flutter'.
  String? instanceName;

  RemoteDevToolsObserver(
    this._host, {
    this.socket,
    this.instanceName,
  }) {
    socket ??= SocketClusterWrapper('ws://$_host/socketcluster/');
    instanceName ??= 'flutter';
  }

  Future<void> connect() async {
    _status = RemoteDevToolsStatus.connecting;
    await socket!.connect();
    _status = RemoteDevToolsStatus.connected;
    _channel = await _login();
    _status = RemoteDevToolsStatus.starting;
    _relay('START');
    await _waitForStart();
  }

  Future<String> _login() {
    final c = Completer<String>();
    socket!.emit('login', 'master', (String name, dynamic error, dynamic data) {
      c.complete(data as String?);
    });
    return c.future;
  }

  Future<dynamic> _waitForStart() {
    final c = Completer();
    socket!.on(_channel, (String name, dynamic data) {
      if (data['type'] == 'START') {
        _status = RemoteDevToolsStatus.started;
        c.complete();
      } else {
        c.completeError(data);
      }
    });
    return c.future;
  }

  String? _getBlocName(BlocBase? bloc) {
    final blocName = bloc.runtimeType.toString();
    final blocHash = bloc.hashCode;
    if (_blocs.containsKey(blocName)) {
      if (!_blocs[blocName]!.containsKey(blocHash)) {
        _blocs[blocName]![blocHash] =
            '$blocName-${_blocs[blocName]!.keys.length}';
      }
    } else {
      _blocs[blocName] = {blocHash: blocName};
    }
    return _blocs[blocName]![blocHash];
  }

  void _removeBlocName(BlocBase? bloc) {
    final blocName = bloc.runtimeType.toString();
    final blocHash = bloc.hashCode;
    if (_blocs.containsKey(blocName) &&
        _blocs[blocName]!.containsKey(blocHash)) {
      _blocs[blocName]!.remove(blocHash);
    }
  }

  void _relay(String type,
      [BlocBase? bloc, Object? state, dynamic action, String? nextActionId]) {
    final message = {'type': type, 'id': socket!.id, 'name': instanceName};
    final blocName = _getBlocName(bloc);

    if (state != null) {
      /// Add or update Bloc state
      if (state is Mappable) {
        _appState[blocName] = state.toMap();
        message['payload'] = jsonEncode(_appState);
      } else {
        _appState[blocName] = state.toString();
        message['payload'] = jsonEncode(_appState);
      }
    } else {
      /// Remove Bloc state
      if (_appState.containsKey(blocName)) {
        _removeBlocName(bloc);
        _appState.remove(blocName);
        message['payload'] = jsonEncode(_appState);
      }
    }

    if (type == 'ACTION') {
      message['action'] = _actionEncode(action);
      message['nextActionId'] = nextActionId;
    } else if (action != null) {
      message['action'] = action as String;
    }
    socket!.emit(socket!.id != null ? 'log' : 'log-noid', message);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (status == RemoteDevToolsStatus.started) {
      _relay('ACTION', bloc, transition.nextState, transition.event);
    }
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (status == RemoteDevToolsStatus.started) {
      _relay('ACTION', bloc, bloc.state, 'OnCreate');
    }
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (status == RemoteDevToolsStatus.started) {
      _relay('ACTION', bloc, null, 'OnClose');
    }
  }

  String _actionEncode(dynamic action) {
    if (action is Mappable) {
      if (action.toMap().keys.isEmpty) {
        return jsonEncode({
          'type': action.runtimeType.toString(),
        });
      }
      return jsonEncode({
        'type': action.runtimeType.toString(),
        'payload': action.toMap(),
      });
    }

    if (action.toString().contains('Instance of')) {
      return jsonEncode({
        'type': action.runtimeType.toString(),
      });
    }

    return jsonEncode({
      'type': action.toString(),
    });
  }
}
