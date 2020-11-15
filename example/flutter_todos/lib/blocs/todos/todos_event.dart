import 'package:equatable/equatable.dart';
import 'package:flutter_todos/models/models.dart';
import 'package:flutter_bloc_devtools/flutter_bloc_devtools.dart';

abstract class TodosEvent extends Equatable implements Mappable {
  const TodosEvent();

  @override
  List<Object> get props => [];

  @override
  Map<String, dynamic> toMap() => {};
}

class TodosLoaded extends TodosEvent {}

class TodoAdded extends TodosEvent {
  final Todo todo;

  const TodoAdded(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  Map<String, dynamic> toMap() => {
        'todo': todo.toEntity().toJson(),
      };
}

class TodoUpdated extends TodosEvent {
  final Todo todo;

  const TodoUpdated(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  Map<String, dynamic> toMap() => {
        'todo': todo.toEntity().toJson(),
      };
}

class TodoDeleted extends TodosEvent {
  final Todo todo;

  const TodoDeleted(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  Map<String, dynamic> toMap() => {
        'todo': todo.toEntity().toJson(),
      };
}

class ClearCompleted extends TodosEvent {}

class ToggleAll extends TodosEvent {}
