import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_solid/ui_package.dart/screens/todo_screen.dart';
import 'data_package/models/todo.dart';
import 'data_package/local_storage/hive_storage.dart';
import 'repository_package/task_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TodoAdapter());

  final box = await Hive.openBox<Todo>('todoBox');
  await box.clear();

  final hiveStorage = HiveStorage();
  final repository = TodoRepository(hiveStorage);

  runApp(MaterialApp(
    home: TodoScreen(repository: repository),
  ));
}
