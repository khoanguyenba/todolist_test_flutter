import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/todo.dart';
import '../../domain/usecases/create_todo.dart' as create_todo_usecase;
import '../../domain/usecases/delete_todo.dart' as delete_todo_usecase;
import '../../domain/usecases/get_all_todos.dart';
import '../../domain/usecases/update_todo.dart' as update_todo_usecase;
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetAllTodos getAllTodos;
  final create_todo_usecase.CreateTodo createTodo;
  final update_todo_usecase.UpdateTodo updateTodo;
  final delete_todo_usecase.DeleteTodo deleteTodo;

  TodoBloc({
    required this.getAllTodos,
    required this.createTodo,
    required this.updateTodo,
    required this.deleteTodo,
  }) : super(TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<CreateTodo>(_onCreateTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<ToggleTodoCompletion>(_onToggleTodoCompletion);
    on<FilterTodos>(_onFilterTodos);
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    
    final result = await getAllTodos(NoParams());
    result.fold(
      (failure) => emit(TodoError(message: _mapFailureToMessage(failure))),
      (todos) => emit(TodoLoaded(todos: todos)),
    );
  }

  Future<void> _onCreateTodo(CreateTodo event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      
      final newTodo = Todo(
        id: const Uuid().v4(),
        title: event.title,
        description: event.description,
        isCompleted: false,
        createdAt: DateTime.now(),
      );

      final result = await createTodo(create_todo_usecase.CreateTodoParams(todo: newTodo));
      result.fold(
        (failure) => emit(TodoError(message: _mapFailureToMessage(failure))),
        (createdTodo) {
          final updatedTodos = <Todo>[...currentState.todos, createdTodo];
          emit(TodoLoaded(
            todos: updatedTodos,
            currentFilter: currentState.currentFilter,
          ));
        },
      );
    }
  }

  Future<void> _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      
      final result = await updateTodo(update_todo_usecase.UpdateTodoParams(todo: event.todo));
      result.fold(
        (failure) => emit(TodoError(message: _mapFailureToMessage(failure))),
        (updatedTodo) {
          final updatedTodos = currentState.todos
              .map<Todo>((todo) => todo.id == updatedTodo.id ? updatedTodo : todo)
              .toList();
          emit(TodoLoaded(
            todos: updatedTodos,
            currentFilter: currentState.currentFilter,
          ));
        },
      );
    }
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      
      final result = await deleteTodo(delete_todo_usecase.DeleteTodoParams(id: event.id));
      result.fold(
        (failure) => emit(TodoError(message: _mapFailureToMessage(failure))),
        (_) {
          final updatedTodos = currentState.todos
              .where((todo) => todo.id != event.id)
              .toList();
          emit(TodoLoaded(
            todos: updatedTodos,
            currentFilter: currentState.currentFilter,
          ));
        },
      );
    }
  }

  Future<void> _onToggleTodoCompletion(ToggleTodoCompletion event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      final todo = currentState.todos.firstWhere((t) => t.id == event.id);
      
      final updatedTodo = todo.copyWith(
        isCompleted: !todo.isCompleted,
        updatedAt: DateTime.now(),
      );
      
      add(UpdateTodo(todo: updatedTodo));
    }
  }

  void _onFilterTodos(FilterTodos event, Emitter<TodoState> emit) {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      emit(TodoLoaded(
        todos: currentState.todos,
        currentFilter: event.filter,
      ));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return 'Cache error: ${failure.message}';
      case ServerFailure:
        return 'Server error: ${failure.message}';
      case ValidationFailure:
        return 'Validation error: ${failure.message}';
      default:
        return 'Unexpected error: ${failure.message}';
    }
  }
}

