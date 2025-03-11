import 'package:hive/hive.dart';
import 'package:todo_solid/models/task.dart';

abstract class TaskRepository {
  List<Task> getTasks();
  void addTask(Task task);
  void updateTask(Task task);
  void deleteTask(String id);
}

class HiveTaskRepository implements TaskRepository {
  static const String _boxName = 'tasks';

  @override
  List<Task> getTasks() {
    final box = Hive.box<Task>(_boxName);
    return box.values.toList();
  }

  @override
  void addTask(Task task) {
    final box = Hive.box<Task>(_boxName);
    box.put(task.id, task);
  }

  @override
  void updateTask(Task task) {
    final box = Hive.box<Task>(_boxName);
    box.put(task.id, task);
  }

  @override
  void deleteTask(String id) {
    final box = Hive.box<Task>(_boxName);
    box.delete(id);
  }
}
