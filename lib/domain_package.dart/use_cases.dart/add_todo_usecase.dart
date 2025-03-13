import 'package:todo_solid/repository_package/task_repository.dart';

import '../../data_package/models/todo.dart';

class AddTodoUseCase {
  final TodoRepository repository;

  AddTodoUseCase(this.repository);

  void execute(Todo todo) {
    repository.addTodo(todo);
  }
}
