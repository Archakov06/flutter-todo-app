import 'package:flutter/material.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo App',
      home: new TodoList(title: 'Список задач'),
    );
  }
}

class TodoList extends StatefulWidget {
  final String title;

  TodoList({Key key, this.title}) : super(key: key);

  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> tasks = [];
  TextEditingController addDialogInput = new TextEditingController();

  void addItem() {
    setState(() {
      tasks.add(addDialogInput.text);
    });
    Navigator.of(context).pop();
  }

  void showAddDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Введите текст задачи'),
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    controller: addDialogInput,
                    decoration: InputDecoration(hintText: 'Текст задачи...'),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Закрыть"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Добавить"),
                onPressed: addItem,
              )
            ],
          );
        });
  }

  void removeItem(text) {
    setState(() {
      tasks.remove(text);
    });
  }

  Widget _buildTodoItem(String todoText, index) {
    return new ListTile(
        title: new Text(todoText),
        trailing: new IconButton(
            icon: new Icon(Icons.delete),
            onPressed: () {
              removeItem(todoText);
            }));
  }

  Widget buildList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < tasks.length) {
          return _buildTodoItem(tasks[index], index);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text(widget.title)),
      body: buildList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: showAddDialog,
          tooltip: 'Добавить задачу',
          child: new Icon(Icons.add)),
    );
  }
}
