part of 'counter_bloc.dart';

class CounterState extends Equatable {
  final int counter;

  const CounterState({
    this.counter,
  });

  CounterState copyWith({
    int counter,
  }) =>
      CounterState(
        counter: counter ?? this.counter,
      );

  @override
  List<Object> get props => [
        counter,
      ];

  @override
  Map<String, dynamic> toJson() => {
        'counter': counter,
      };
}
