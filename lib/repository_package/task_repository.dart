
import 'package:todo_solid/data_package/local_storage/hive_storage.dart';
import 'package:todo_solid/data_package/models/todo.dart';

class TodoRepository {
  final HiveStorage hiveStorage;

  TodoRepository(this.hiveStorage);

  List<Todo> fetchTodos() => hiveStorage.getTodos();

  void addTodo(Todo todo) => hiveStorage.addTodo(todo);

  void deleteTodo(String id) => hiveStorage.deleteTodo(id);

  void updateTodo(Todo todo) => hiveStorage.updateTodo(todo);
}
