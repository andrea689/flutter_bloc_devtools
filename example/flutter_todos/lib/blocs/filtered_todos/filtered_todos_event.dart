import 'package:equatable/equatable.dart';
import 'package:flutter_todos/models/models.dart';
import 'package:flutter_bloc_devtools/flutter_bloc_devtools.dart';

abstract class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();

  @override
  Map<String, dynamic> toJson() => {};
}

class FilterUpdated extends FilteredTodosEvent {
  final VisibilityFilter filter;

  const FilterUpdated(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  Map<String, dynamic> toJson() => {
        'filter': filter.toString().substring('VisibilityFilter.'.length),
      };
}

class TodosUpdated extends FilteredTodosEvent {
  final List<Todo> todos;

  const TodosUpdated(this.todos);

  @override
  List<Object> get props => [todos];

  @override
  Map<String, dynamic> toJson() => {
        'todos': todos.map((e) => e.toEntity().toJson()).toList(),
      };
}
