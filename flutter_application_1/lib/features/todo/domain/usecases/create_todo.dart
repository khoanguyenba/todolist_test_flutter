import '../common/result.dart';
import '../common/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

/// Use Case: Tạo Todo mới
/// Business logic để thêm một công việc mới vào danh sách
class CreateTodo implements UseCase<Todo, CreateTodoParams> {
  final TodoRepository repository;

  const CreateTodo(this.repository);

  /// Thực hiện tạo todo mới
  @override
  Future<Result<Todo>> call(CreateTodoParams params) async {
    return await repository.createTodo(params.todo);
  }
}

/// Tham số cho CreateTodo use case
/// Chứa thông tin Todo cần tạo
class CreateTodoParams {
  final Todo todo;

  const CreateTodoParams({required this.todo});

  @override
  String toString() => 'CreateTodoParams(todo: $todo)';
}


