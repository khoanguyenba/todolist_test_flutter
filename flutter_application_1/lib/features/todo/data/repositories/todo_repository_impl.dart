import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_data_source.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Todo>>> getAllTodos() async {
    try {
      final todoModels = await localDataSource.getAllTodos();
      final todos = todoModels.map((model) => model.toEntity()).toList();
      return Right(todos);
    } catch (e) {
      return Left(CacheFailure('Failed to get todos: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Todo>> getTodoById(String id) async {
    try {
      final todoModel = await localDataSource.getTodoById(id);
      return Right(todoModel.toEntity());
    } catch (e) {
      return Left(CacheFailure('Failed to get todo: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Todo>> createTodo(Todo todo) async {
    try {
      final todoModel = TodoModel.fromEntity(todo);
      final createdTodo = await localDataSource.createTodo(todoModel);
      return Right(createdTodo.toEntity());
    } catch (e) {
      return Left(CacheFailure('Failed to create todo: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Todo>> updateTodo(Todo todo) async {
    try {
      final todoModel = TodoModel.fromEntity(todo);
      final updatedTodo = await localDataSource.updateTodo(todoModel);
      return Right(updatedTodo.toEntity());
    } catch (e) {
      return Left(CacheFailure('Failed to update todo: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(String id) async {
    try {
      await localDataSource.deleteTodo(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to delete todo: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getCompletedTodos() async {
    try {
      final todoModels = await localDataSource.getCompletedTodos();
      final todos = todoModels.map((model) => model.toEntity()).toList();
      return Right(todos);
    } catch (e) {
      return Left(CacheFailure('Failed to get completed todos: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getPendingTodos() async {
    try {
      final todoModels = await localDataSource.getPendingTodos();
      final todos = todoModels.map((model) => model.toEntity()).toList();
      return Right(todos);
    } catch (e) {
      return Left(CacheFailure('Failed to get pending todos: ${e.toString()}'));
    }
  }
}


