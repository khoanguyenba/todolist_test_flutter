import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getAllTodos();
  Future<Either<Failure, Todo>> getTodoById(String id);
  Future<Either<Failure, Todo>> createTodo(Todo todo);
  Future<Either<Failure, Todo>> updateTodo(Todo todo);
  Future<Either<Failure, void>> deleteTodo(String id);
  Future<Either<Failure, List<Todo>>> getCompletedTodos();
  Future<Either<Failure, List<Todo>>> getPendingTodos();
}


