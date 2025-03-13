import 'package:flutter/material.dart';
import '../../data_package/models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(String) onDelete;

  const TodoItem({Key? key, required this.todo, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => onDelete(todo.id),
      ),
    );
  }
}
