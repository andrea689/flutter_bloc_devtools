part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable implements Mappable {
  const CounterEvent();

  @override
  List<Object> get props => [];

  @override
  Map<String, dynamic> toMap() => {};
}

class IncrementCounterEvent extends CounterEvent {}

class DecrementCounterEvent extends CounterEvent {}
