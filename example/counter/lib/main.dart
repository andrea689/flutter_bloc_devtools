import 'package:bloc/bloc.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_devtools/flutter_bloc_devtools.dart';

import 'app.dart';

void main() async {
  BlocOverrides.runZoned(
    () async => runApp(const CounterApp()),
    blocObserver: RemoteDevToolsObserver('127.0.0.1:8000'),
    // NOTE: 127.0.0.1 works for web builds. If you are building to the android device or emulator, you need your local ip, like 192.168.0.112.
  );
}
