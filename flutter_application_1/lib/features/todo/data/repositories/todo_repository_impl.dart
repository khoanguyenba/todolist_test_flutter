import '../../domain/common/result.dart';
import '../../domain/common/failures.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_data_source.dart';
import '../models/todo_model.dart';

/// Implementation of TodoRepository using local data source
class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  const TodoRepositoryImpl({required this.localDataSource});

  @override
  Future<Result<List<Todo>>> getAllTodos() async {
    try {
      final todoModels = await localDataSource.getAllTodos();
      final todos = todoModels.map((model) => model.toEntity()).toList();
      return Success(todos);
    } catch (e) {
      return Failure(CacheFailure('Failed to get todos: ${e.toString()}').message);
    }
  }

  @override
  Future<Result<Todo>> getTodoById(String id) async {
    try {
      final todoModel = await localDataSource.getTodoById(id);
      return Success(todoModel.toEntity());
    } catch (e) {
      return Failure(CacheFailure('Failed to get todo: ${e.toString()}').message);
    }
  }

  @override
  Future<Result<Todo>> createTodo(Todo todo) async {
    try {
      final todoModel = TodoModel.fromEntity(todo);
      final createdTodo = await localDataSource.createTodo(todoModel);
      return Success(createdTodo.toEntity());
    } catch (e) {
      return Failure(CacheFailure('Failed to create todo: ${e.toString()}').message);
    }
  }

  @override
  Future<Result<Todo>> updateTodo(Todo todo) async {
    try {
      final todoModel = TodoModel.fromEntity(todo);
      final updatedTodo = await localDataSource.updateTodo(todoModel);
      return Success(updatedTodo.toEntity());
    } catch (e) {
      return Failure(CacheFailure('Failed to update todo: ${e.toString()}').message);
    }
  }

  @override
  Future<Result<void>> deleteTodo(String id) async {
    try {
      await localDataSource.deleteTodo(id);
      return const Success(null);
    } catch (e) {
      return Failure(CacheFailure('Failed to delete todo: ${e.toString()}').message);
    }
  }

  @override
  Future<Result<List<Todo>>> getCompletedTodos() async {
    try {
      final todoModels = await localDataSource.getCompletedTodos();
      final todos = todoModels.map((model) => model.toEntity()).toList();
      return Success(todos);
    } catch (e) {
      return Failure(CacheFailure('Failed to get completed todos: ${e.toString()}').message);
    }
  }

  @override
  Future<Result<List<Todo>>> getPendingTodos() async {
    try {
      final todoModels = await localDataSource.getPendingTodos();
      final todos = todoModels.map((model) => model.toEntity()).toList();
      return Success(todos);
    } catch (e) {
      return Failure(CacheFailure('Failed to get pending todos: ${e.toString()}').message);
    }
  }
}


