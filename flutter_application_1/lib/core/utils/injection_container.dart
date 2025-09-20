import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../usecases/usecase.dart';
import '../../features/todo/data/datasources/todo_local_data_source.dart';
import '../../features/todo/data/repositories/todo_repository_impl.dart';
import '../../features/todo/domain/repositories/todo_repository.dart';
import '../../features/todo/domain/usecases/create_todo.dart';
import '../../features/todo/domain/usecases/delete_todo.dart';
import '../../features/todo/domain/usecases/get_all_todos.dart';
import '../../features/todo/domain/usecases/update_todo.dart';
import '../../features/todo/presentation/bloc/todo_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Todo
  // Bloc
  sl.registerFactory(
    () => TodoBloc(
      getAllTodos: sl(),
      createTodo: sl(),
      updateTodo: sl(),
      deleteTodo: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllTodos(sl()));
  sl.registerLazySingleton(() => CreateTodo(sl()));
  sl.registerLazySingleton(() => UpdateTodo(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));

  // Repository
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}


