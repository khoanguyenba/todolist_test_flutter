import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';
import '../widgets/add_todo_dialog.dart';
import '../widgets/todo_filter_chips.dart';
import '../widgets/todo_item.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TodoLoaded) {
            return Column(
              children: [
                TodoFilterChips(
                  currentFilter: state.currentFilter,
                  onFilterChanged: (filter) {
                    context.read<TodoBloc>().add(FilterTodos(filter: filter));
                  },
                ),
                Expanded(
                  child: state.filteredTodos.isEmpty
                      ? const Center(
                          child: Text(
                            'Không có todo nào',
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      : ListView.builder(
                          itemCount: state.filteredTodos.length,
                          itemBuilder: (context, index) {
                            final todo = state.filteredTodos[index];
                            return TodoItem(
                              todo: todo,
                              onToggle: () {
                                context.read<TodoBloc>().add(
                                      ToggleTodoCompletion(id: todo.id),
                                    );
                              },
                              onDelete: () {
                                _showDeleteConfirmation(context, todo.id);
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          }

          return const Center(
            child: Text('Đã xảy ra lỗi'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context),
        tooltip: 'Thêm Todo',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddTodoDialog(),
    ).then((result) {
      if (result != null) {
        context.read<TodoBloc>().add(
              CreateTodo(
                title: result['title'],
                description: result['description'],
              ),
            );
      }
    });
  }

  void _showDeleteConfirmation(BuildContext context, String todoId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc chắn muốn xóa todo này không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<TodoBloc>().add(DeleteTodo(id: todoId));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }
}


