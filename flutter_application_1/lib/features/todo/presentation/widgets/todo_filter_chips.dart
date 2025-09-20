import 'package:flutter/material.dart';
import '../bloc/todo_event.dart';

class TodoFilterChips extends StatelessWidget {
  final TodoFilter currentFilter;
  final Function(TodoFilter) onFilterChanged;

  const TodoFilterChips({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: FilterChip(
              label: const Text('Tất cả'),
              selected: currentFilter == TodoFilter.all,
              onSelected: (_) => onFilterChanged(TodoFilter.all),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: FilterChip(
              label: const Text('Chưa hoàn thành'),
              selected: currentFilter == TodoFilter.pending,
              onSelected: (_) => onFilterChanged(TodoFilter.pending),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: FilterChip(
              label: const Text('Đã hoàn thành'),
              selected: currentFilter == TodoFilter.completed,
              onSelected: (_) => onFilterChanged(TodoFilter.completed),
            ),
          ),
        ],
      ),
    );
  }
}


