import '../../domain/entities/todo.dart';

/// Lớp cơ sở cho tất cả các sự kiện Todo
/// Event là các hành động mà người dùng thực hiện (như tạo, xóa, cập nhật)
abstract class TodoEvent {
  const TodoEvent();
}

/// Sự kiện: Tải danh sách tất cả todos
/// Được gọi khi mở ứng dụng hoặc refresh danh sách
class LoadTodos extends TodoEvent {
  const LoadTodos();
}

/// Sự kiện: Tạo todo mới
/// Chứa thông tin title và description của todo cần tạo
class CreateTodo extends TodoEvent {
  final String title;        // Tiêu đề todo
  final String description;  // Mô tả todo

  const CreateTodo({
    required this.title,
    required this.description,
  });

  @override
  String toString() => 'CreateTodo(title: $title, description: $description)';
}

/// Sự kiện: Cập nhật todo đã có
/// Chứa thông tin todo đã được sửa đổi
class UpdateTodo extends TodoEvent {
  final Todo todo;  // Todo đã được cập nhật

  const UpdateTodo({required this.todo});

  @override
  String toString() => 'UpdateTodo(todo: $todo)';
}

/// Sự kiện: Xóa todo
/// Chỉ cần ID của todo cần xóa
class DeleteTodo extends TodoEvent {
  final String id;  // ID của todo cần xóa

  const DeleteTodo({required this.id});

  @override
  String toString() => 'DeleteTodo(id: $id)';
}

/// Sự kiện: Đánh dấu hoàn thành/chưa hoàn thành
/// Chỉ cần ID của todo cần thay đổi trạng thái
class ToggleTodoCompletion extends TodoEvent {
  final String id;  // ID của todo cần thay đổi

  const ToggleTodoCompletion({required this.id});

  @override
  String toString() => 'ToggleTodoCompletion(id: $id)';
}

/// Sự kiện: Lọc danh sách todo
/// Chứa loại bộ lọc muốn áp dụng
class FilterTodos extends TodoEvent {
  final TodoFilter filter;  // Loại bộ lọc

  const FilterTodos({required this.filter});

  @override
  String toString() => 'FilterTodos(filter: $filter)';
}

/// Các loại bộ lọc cho danh sách todo
enum TodoFilter { 
  all,        // Tất cả
  completed,  // Đã hoàn thành
  pending     // Chưa hoàn thành
}


