import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_devtools/flutter_bloc_devtools.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(counter: 0)) {
    on<IncrementCounterEvent>(_doIncrement);
    on<DecrementCounterEvent>(_doDecrement);
  }

  void _doIncrement(
    IncrementCounterEvent event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(counter: state.counter + 1));
  }

  void _doDecrement(
    DecrementCounterEvent event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(counter: state.counter - 1));
  }

  // Stream<CounterState> mapEventToState(
  //   CounterEvent event,
  // ) async* {
  //   if (event is IncrementCounterEvent) {
  //     yield state.copyWith(
  //       counter: state.counter + 1,
  //     );
  //   }
  //   if (event is DecrementCounterEvent) {
  //     yield state.copyWith(
  //       counter: state.counter - 1,
  //     );
  //   }
  // }
}
