import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/utils/injection_container.dart' as di;
import 'features/todo/presentation/bloc/todo_bloc.dart';
import 'features/todo/presentation/bloc/todo_event.dart';
import 'features/todo/presentation/pages/todo_page.dart';

/// Main entry point of the application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

/// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App - Clean Architecture',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => di.sl<TodoBloc>()..add(const LoadTodos()),
        child: const TodoPage(),
      ),
    );
  }
}
