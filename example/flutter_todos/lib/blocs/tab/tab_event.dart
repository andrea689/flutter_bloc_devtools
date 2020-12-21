import 'package:equatable/equatable.dart';
import 'package:flutter_todos/models/models.dart';
import 'package:flutter_bloc_devtools/flutter_bloc_devtools.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();

  @override
  Map<String, dynamic> toJson() => {};
}

class TabUpdated extends TabEvent {
  final AppTab tab;

  const TabUpdated(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  Map<String, dynamic> toJson() => {
        'tab': tab.toString(),
      };
}
