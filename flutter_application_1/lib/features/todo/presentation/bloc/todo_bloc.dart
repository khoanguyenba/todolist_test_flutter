import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../domain/common/result.dart';
import '../../domain/common/usecase.dart';
import '../../domain/entities/todo.dart';
import '../../domain/usecases/create_todo.dart' as create_todo_usecase;
import '../../domain/usecases/delete_todo.dart' as delete_todo_usecase;
import '../../domain/usecases/get_all_todos.dart';
import '../../domain/usecases/update_todo.dart' as update_todo_usecase;
import 'todo_event.dart';
import 'todo_state.dart';

/// BLoC quản lý trạng thái và logic của Todo
/// Đây là cầu nối giữa UI và business logic
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  // Các use cases để thực hiện business logic
  final GetAllTodos getAllTodos;
  final create_todo_usecase.CreateTodo createTodo;
  final update_todo_usecase.UpdateTodo updateTodo;
  final delete_todo_usecase.DeleteTodo deleteTodo;

  TodoBloc({
    required this.getAllTodos,
    required this.createTodo,
    required this.updateTodo,
    required this.deleteTodo,
  }) : super(TodoInitial()) {
    // Đăng ký các event handlers
    on<LoadTodos>(_onLoadTodos);
    on<CreateTodo>(_onCreateTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<ToggleTodoCompletion>(_onToggleTodoCompletion);
    on<FilterTodos>(_onFilterTodos);
  }

  /// Xử lý event LoadTodos - Lấy danh sách tất cả todos
  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading()); // Hiển thị loading
    
    final result = await getAllTodos(const NoParams());
    if (result.isSuccess) {
      emit(TodoLoaded(todos: result.data!)); // Hiển thị danh sách
    } else {
      emit(TodoError(message: result.error!)); // Hiển thị lỗi
    }
  }

  /// Xử lý event CreateTodo - Tạo todo mới
  Future<void> _onCreateTodo(CreateTodo event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      
      // Tạo todo mới với thông tin từ event
      final newTodo = Todo(
        id: const Uuid().v4(), // Tạo ID duy nhất
        title: event.title,
        description: event.description,
        isCompleted: false, // Mặc định chưa hoàn thành
        createdAt: DateTime.now(),
      );

      // Gọi use case để tạo todo
      final result = await createTodo(create_todo_usecase.CreateTodoParams(todo: newTodo));
      if (result.isSuccess) {
        // Thêm todo mới vào danh sách hiện tại
        final updatedTodos = <Todo>[...currentState.todos, result.data!];
        emit(TodoLoaded(
          todos: updatedTodos,
          currentFilter: currentState.currentFilter,
        ));
      } else {
        emit(TodoError(message: result.error!));
      }
    }
  }

  /// Xử lý event UpdateTodo - Cập nhật todo
  Future<void> _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      
      final result = await updateTodo(update_todo_usecase.UpdateTodoParams(todo: event.todo));
      if (result.isSuccess) {
        // Cập nhật todo trong danh sách
        final updatedTodos = currentState.todos
            .map<Todo>((todo) => todo.id == result.data!.id ? result.data! : todo)
            .toList();
        emit(TodoLoaded(
          todos: updatedTodos,
          currentFilter: currentState.currentFilter,
        ));
      } else {
        emit(TodoError(message: result.error!));
      }
    }
  }

  /// Xử lý event DeleteTodo - Xóa todo
  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      
      final result = await deleteTodo(delete_todo_usecase.DeleteTodoParams(id: event.id));
      if (result.isSuccess) {
        // Loại bỏ todo khỏi danh sách
        final updatedTodos = currentState.todos
            .where((todo) => todo.id != event.id)
            .toList();
        emit(TodoLoaded(
          todos: updatedTodos,
          currentFilter: currentState.currentFilter,
        ));
      } else {
        emit(TodoError(message: result.error!));
      }
    }
  }

  /// Xử lý event ToggleTodoCompletion - Đánh dấu hoàn thành/chưa hoàn thành
  Future<void> _onToggleTodoCompletion(ToggleTodoCompletion event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      final todo = currentState.todos.firstWhere((t) => t.id == event.id);
      
      // Tạo todo mới với trạng thái hoàn thành thay đổi
      final updatedTodo = todo.copyWith(
        isCompleted: !todo.isCompleted,
        updatedAt: DateTime.now(),
      );
      
      // Gọi event UpdateTodo để cập nhật
      add(UpdateTodo(todo: updatedTodo));
    }
  }

  /// Xử lý event FilterTodos - Lọc danh sách todo
  void _onFilterTodos(FilterTodos event, Emitter<TodoState> emit) {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      emit(TodoLoaded(
        todos: currentState.todos,
        currentFilter: event.filter, // Cập nhật bộ lọc
      ));
    }
  }
}

