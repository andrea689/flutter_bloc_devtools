import 'package:bloc/bloc.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_devtools/flutter_bloc_devtools.dart';

import 'app.dart';

void main() async {
  // final observer = RemoteDevToolsObserver('192.168.1.7:8000');
  // await observer.connect();
  // Bloc.observer = observer;
  //
  // runApp(const CounterApp());
  BlocOverrides.runZoned(
    () async => runApp(const CounterApp()),
    blocObserver: RemoteDevToolsObserver('127.0.0.1:8000'),
  );
}
