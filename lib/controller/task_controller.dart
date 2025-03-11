import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_solid/repo/task_repository.dart';
import '../models/task.dart';

class TaskController extends ChangeNotifier {
  final TaskRepository repository;

  TaskController(this.repository);

  List<Task> get tasks => repository.getTasks();

  void addTask(String title) {
    final task = Task(id: DateTime.now().toString(), title: title);
    repository.addTask(task);
    notifyListeners(); // UI ni yangilash
  }

  void toggleTaskCompletion(String id) {
    final task = tasks.firstWhere((t) => t.id == id);
    repository.updateTask(task.copyWith(isCompleted: !task.isCompleted));
    notifyListeners();
  }

  void deleteTask(String id) {
    repository.deleteTask(id);
    notifyListeners(); 
  }
}
