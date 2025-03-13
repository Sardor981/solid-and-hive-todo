import 'package:hive/hive.dart';
import '../models/todo.dart';

class HiveStorage {
  final _todoBox = Hive.box<Todo>('todoBox');

  List<Todo> getTodos() {
    return _todoBox.values.cast<Todo>().toList();
  }

  void addTodo(Todo todo) {
    _todoBox.put(todo.id, todo);
  }

  void deleteTodo(String id) {
    _todoBox.delete(id);
  }

  void updateTodo(Todo updatedTodo) {
    _todoBox.put(updatedTodo.id, updatedTodo); 
  }
}
