import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getAllTodos();
  Future<TodoModel> getTodoById(String id);
  Future<TodoModel> createTodo(TodoModel todo);
  Future<TodoModel> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
  Future<List<TodoModel>> getCompletedTodos();
  Future<List<TodoModel>> getPendingTodos();
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _todosKey = 'todos';

  TodoLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TodoModel>> getAllTodos() async {
    final todosJson = sharedPreferences.getStringList(_todosKey) ?? [];
    return todosJson
        .map((todoJson) => TodoModel.fromJson(json.decode(todoJson)))
        .toList();
  }

  @override
  Future<TodoModel> getTodoById(String id) async {
    final todos = await getAllTodos();
    final todo = todos.firstWhere((todo) => todo.id == id);
    return todo;
  }

  @override
  Future<TodoModel> createTodo(TodoModel todo) async {
    final todos = await getAllTodos();
    final updatedTodos = [...todos, todo];
    await _saveTodos(updatedTodos);
    return todo;
  }

  @override
  Future<TodoModel> updateTodo(TodoModel todo) async {
    final todos = await getAllTodos();
    final index = todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
      await _saveTodos(todos);
    }
    return todo;
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = await getAllTodos();
    todos.removeWhere((todo) => todo.id == id);
    await _saveTodos(todos);
  }

  @override
  Future<List<TodoModel>> getCompletedTodos() async {
    final todos = await getAllTodos();
    return todos.where((todo) => todo.isCompleted).toList();
  }

  @override
  Future<List<TodoModel>> getPendingTodos() async {
    final todos = await getAllTodos();
    return todos.where((todo) => !todo.isCompleted).toList();
  }

  Future<void> _saveTodos(List<TodoModel> todos) async {
    final todosJson = todos
        .map((todo) => json.encode(todo.toJson()))
        .toList();
    await sharedPreferences.setStringList(_todosKey, todosJson);
  }
}


