import '../../domain/entities/todo.dart';
import 'todo_event.dart';

/// Lớp cơ sở cho tất cả các trạng thái Todo
/// State đại diện cho trạng thái hiện tại của ứng dụng
abstract class TodoState {
  const TodoState();
}

/// Trạng thái ban đầu khi ứng dụng khởi động
/// Chưa có dữ liệu gì cả
class TodoInitial extends TodoState {
  const TodoInitial();

  @override
  String toString() => 'TodoInitial()';
}

/// Trạng thái đang tải dữ liệu
/// Hiển thị loading spinner cho người dùng
class TodoLoading extends TodoState {
  const TodoLoading();

  @override
  String toString() => 'TodoLoading()';
}

/// Trạng thái đã tải thành công danh sách todos
/// Chứa danh sách todos và bộ lọc hiện tại
class TodoLoaded extends TodoState {
  final List<Todo> todos;           // Danh sách tất cả todos
  final TodoFilter currentFilter;   // Bộ lọc hiện tại

  const TodoLoaded({
    required this.todos,
    this.currentFilter = TodoFilter.all,
  });

  /// Lấy danh sách todos đã được lọc theo bộ lọc hiện tại
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

  @override
  String toString() => 'TodoLoaded(todos: ${todos.length}, currentFilter: $currentFilter)';
}

/// Trạng thái lỗi khi có sự cố xảy ra
/// Chứa thông báo lỗi để hiển thị cho người dùng
class TodoError extends TodoState {
  final String message;  // Thông báo lỗi

  const TodoError({required this.message});

  @override
  String toString() => 'TodoError(message: $message)';
}


