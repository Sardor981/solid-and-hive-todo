import 'package:flutter/material.dart';
import '../../repository_package/task_repository.dart';
import '../../data_package/models/todo.dart';

class TodoScreen extends StatefulWidget {
  final TodoRepository repository;

  const TodoScreen({Key? key, required this.repository}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late List<Todo> todos;
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    todos = widget.repository.fetchTodos();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _addTodo() async {
    _textController.clear();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Todo'),
        content: TextField(
          controller: _textController,
          decoration: const InputDecoration(
            hintText: 'Enter todo title',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                Navigator.pop(context, _textController.text);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        final newTodo = Todo(
          id: DateTime.now().toString(),
          title: result,
        );
        widget.repository.addTodo(newTodo);
        todos = widget.repository.fetchTodos();
      });
    }
  }

  void _deleteTodo(String id) {
    setState(() {
      widget.repository.deleteTodo(id);
      todos = widget.repository.fetchTodos();
    });
  }

  void _updateTodo(Todo todo) {
    final updatedTodo = Todo(
      id: todo.id,
      title: todo.title,
      isCompleted: !todo.isCompleted,
    );

    widget.repository.updateTodo(updatedTodo);
    setState(() {
      todos = widget.repository.fetchTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo App')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo.title),
            subtitle: Text(todo.isCompleted ? 'Completed' : 'Incomplete'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    todo.isCompleted
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                  ),
                  onPressed: () => _updateTodo(todo),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteTodo(todo.id),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
