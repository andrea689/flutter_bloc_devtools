import 'package:equatable/equatable.dart';
import 'package:flutter_todos/models/models.dart';
import 'package:flutter_bloc_devtools/flutter_bloc_devtools.dart';

abstract class FilteredTodosState extends Equatable implements Mappable {
  const FilteredTodosState();

  @override
  List<Object> get props => [];

  @override
  Map<String, dynamic> toMap() => {};
}

class FilteredTodosLoadInProgress extends FilteredTodosState {}

class FilteredTodosLoadSuccess extends FilteredTodosState {
  final List<Todo> filteredTodos;
  final VisibilityFilter activeFilter;

  const FilteredTodosLoadSuccess(
    this.filteredTodos,
    this.activeFilter,
  );

  @override
  List<Object> get props => [filteredTodos, activeFilter];

  @override
  Map<String, dynamic> toMap() => {
        'filteredTodos':
            filteredTodos.map((e) => e.toEntity().toJson()).toList(),
        'activeFilter':
            activeFilter.toString().substring('VisibilityFilter.'.length),
      };
}
