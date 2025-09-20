import 'package:equatable/equatable.dart';
import '../../domain/entities/todo.dart';
import 'todo_event.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;
  final TodoFilter currentFilter;

  const TodoLoaded({
    required this.todos,
    this.currentFilter = TodoFilter.all,
  });

  @override
  List<Object> get props => [todos, currentFilter];

  List<Todo> get filteredTodos {
    switch (currentFilter) {
      case TodoFilter.completed:
        return todos.where((todo) => todo.isCompleted).toList();
      case TodoFilter.pending:
        return todos.where((todo) => !todo.isCompleted).toList();
      case TodoFilter.all:
      default:
        return todos;
    }
  }
}

class TodoError extends TodoState {
  final String message;

  const TodoError({required this.message});

  @override
  List<Object> get props => [message];
}


