import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_solid/controller/task_controller.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TaskController>();
    final TextEditingController textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do'),
        centerTitle: true,
        leading: Icon(
          Icons.person,
          color: Colors.blue,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.settings,
              color: Colors.grey,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: controller.tasks.length,
              itemBuilder: (context, index) {
                final task = controller.tasks[index];
                return ListTile(
                  title: Text(task.title),
                  trailing: Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) => controller.toggleTaskCompletion(task.id),
                  ),
                  onLongPress: () {
                    controller.deleteTask(task.id);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("todo o'chirildi"),
                      backgroundColor: Colors.blue,
                      duration: Duration(seconds: 2),
                    ));
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'write a task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      controller.addTask(textController.text);

                      textController.clear();
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
