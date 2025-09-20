import '../common/result.dart';
import '../common/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

/// Use Case: Cập nhật Todo
/// Business logic để sửa đổi thông tin một công việc
class UpdateTodo implements UseCase<Todo, UpdateTodoParams> {
  final TodoRepository repository;

  const UpdateTodo(this.repository);

  /// Thực hiện cập nhật todo
  @override
  Future<Result<Todo>> call(UpdateTodoParams params) async {
    return await repository.updateTodo(params.todo);
  }
}

/// Tham số cho UpdateTodo use case
/// Chứa thông tin Todo cần cập nhật
class UpdateTodoParams {
  final Todo todo;

  const UpdateTodoParams({required this.todo});

  @override
  String toString() => 'UpdateTodoParams(todo: $todo)';
}


