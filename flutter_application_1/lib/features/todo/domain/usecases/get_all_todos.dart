import '../common/result.dart';
import '../common/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

/// Use Case: Lấy tất cả danh sách Todo
/// Đây là business logic để lấy danh sách tất cả công việc
class GetAllTodos implements UseCase<List<Todo>, NoParams> {
  final TodoRepository repository;

  const GetAllTodos(this.repository);

  /// Thực hiện lấy tất cả todos
  @override
  Future<Result<List<Todo>>> call(NoParams params) async {
    return await repository.getAllTodos();
  }
}


