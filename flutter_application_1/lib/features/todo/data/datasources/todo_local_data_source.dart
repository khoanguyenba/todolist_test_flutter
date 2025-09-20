import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo_model.dart';

/// Abstract class for local data source operations
abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getAllTodos();
  Future<TodoModel> getTodoById(String id);
  Future<TodoModel> createTodo(TodoModel todo);
  Future<TodoModel> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
  Future<List<TodoModel>> getCompletedTodos();
  Future<List<TodoModel>> getPendingTodos();
}

/// Implementation of TodoLocalDataSource using SharedPreferences
class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _todosKey = 'todos';

  const TodoLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TodoModel>> getAllTodos() async {
    try {
      final todosJson = sharedPreferences.getStringList(_todosKey) ?? [];
      return todosJson
          .map((todoJson) => TodoModel.fromJson(json.decode(todoJson)))
          .toList();
    } catch (e) {
      throw Exception('Failed to get todos: $e');
    }
  }

  @override
  Future<TodoModel> getTodoById(String id) async {
    try {
      final todos = await getAllTodos();
      final todo = todos.firstWhere((todo) => todo.id == id);
      return todo;
    } catch (e) {
      throw Exception('Failed to get todo by id: $e');
    }
  }

  @override
  Future<TodoModel> createTodo(TodoModel todo) async {
    try {
      final todos = await getAllTodos();
      final updatedTodos = [...todos, todo];
      await _saveTodos(updatedTodos);
      return todo;
    } catch (e) {
      throw Exception('Failed to create todo: $e');
    }
  }

  @override
  Future<TodoModel> updateTodo(TodoModel todo) async {
    try {
      final todos = await getAllTodos();
      final index = todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        todos[index] = todo;
        await _saveTodos(todos);
      }
      return todo;
    } catch (e) {
      throw Exception('Failed to update todo: $e');
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    try {
      final todos = await getAllTodos();
      todos.removeWhere((todo) => todo.id == id);
      await _saveTodos(todos);
    } catch (e) {
      throw Exception('Failed to delete todo: $e');
    }
  }

  @override
  Future<List<TodoModel>> getCompletedTodos() async {
    try {
      final todos = await getAllTodos();
      return todos.where((todo) => todo.isCompleted).toList();
    } catch (e) {
      throw Exception('Failed to get completed todos: $e');
    }
  }

  @override
  Future<List<TodoModel>> getPendingTodos() async {
    try {
      final todos = await getAllTodos();
      return todos.where((todo) => !todo.isCompleted).toList();
    } catch (e) {
      throw Exception('Failed to get pending todos: $e');
    }
  }

  /// Saves todos to SharedPreferences
  Future<void> _saveTodos(List<TodoModel> todos) async {
    try {
      final todosJson = todos
          .map((todo) => json.encode(todo.toJson()))
          .toList();
      await sharedPreferences.setStringList(_todosKey, todosJson);
    } catch (e) {
      throw Exception('Failed to save todos: $e');
    }
  }
}


