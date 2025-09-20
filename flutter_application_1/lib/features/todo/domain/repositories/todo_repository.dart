import '../common/result.dart';
import '../entities/todo.dart';

/// Repository interface for Todo operations
/// This interface defines the contract for data access without external dependencies
abstract class TodoRepository {
  /// Get all todos
  Future<Result<List<Todo>>> getAllTodos();
  
  /// Get a specific todo by ID
  Future<Result<Todo>> getTodoById(String id);
  
  /// Create a new todo
  Future<Result<Todo>> createTodo(Todo todo);
  
  /// Update an existing todo
  Future<Result<Todo>> updateTodo(Todo todo);
  
  /// Delete a todo by ID
  Future<Result<void>> deleteTodo(String id);
  
  /// Get all completed todos
  Future<Result<List<Todo>>> getCompletedTodos();
  
  /// Get all pending (incomplete) todos
  Future<Result<List<Todo>>> getPendingTodos();
}


