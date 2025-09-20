import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class CreateTodo implements UseCase<Todo, CreateTodoParams> {
  final TodoRepository repository;

  CreateTodo(this.repository);

  @override
  Future<Either<Failure, Todo>> call(CreateTodoParams params) async {
    return await repository.createTodo(params.todo);
  }
}

class CreateTodoParams extends Equatable {
  final Todo todo;

  const CreateTodoParams({required this.todo});

  @override
  List<Object> get props => [todo];
}


