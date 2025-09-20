import '../common/result.dart';
import '../common/usecase.dart';
import '../repositories/todo_repository.dart';

/// Use Case: Xóa Todo
/// Business logic để xóa một công việc khỏi danh sách
class DeleteTodo implements UseCase<void, DeleteTodoParams> {
  final TodoRepository repository;

  const DeleteTodo(this.repository);

  /// Thực hiện xóa todo
  @override
  Future<Result<void>> call(DeleteTodoParams params) async {
    return await repository.deleteTodo(params.id);
  }
}

/// Tham số cho DeleteTodo use case
/// Chứa ID của Todo cần xóa
class DeleteTodoParams {
  final String id;

  const DeleteTodoParams({required this.id});

  @override
  String toString() => 'DeleteTodoParams(id: $id)';
}


