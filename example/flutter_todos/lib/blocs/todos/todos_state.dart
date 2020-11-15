import 'package:equatable/equatable.dart';
import 'package:flutter_todos/models/models.dart';
import 'package:flutter_bloc_devtools/flutter_bloc_devtools.dart';

abstract class TodosState extends Equatable implements Mappable {
  const TodosState();

  @override
  List<Object> get props => [];

  @override
  Map<String, dynamic> toMap() => {};
}

class TodosLoadInProgress extends TodosState {}

class TodosLoadSuccess extends TodosState {
  final List<Todo> todos;

  const TodosLoadSuccess([this.todos = const []]);

  @override
  List<Object> get props => [todos];

  @override
  Map<String, dynamic> toMap() =>
      {'todos': todos.map((e) => e.toEntity().toJson()).toList()};
}

class TodosLoadFailure extends TodosState {}
