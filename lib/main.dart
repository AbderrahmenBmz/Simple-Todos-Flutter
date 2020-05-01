import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: SimpleTodo(),
    );
  }
}

class SimpleTodo extends StatefulWidget {
  @override
  _SimpleTodoState createState() => _SimpleTodoState();
}

class _SimpleTodoState extends State<SimpleTodo> {
  List<String> _todoItems = [];

  void _addTodoItem(String item) {
    setState(() => _todoItems.add(item));
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index] , index);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText ,int index) {
    return ListTile(title: Text(todoText),
    onTap: () => _promptRemoveTodoItem(index),);
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Add a new Task pls '),
        ),
        body: Center(
          child: TextField(
            autofocus: true,
            onSubmitted: (value) {
              _addTodoItem(value);
              Navigator.pop(context);
            },
            decoration: InputDecoration(
                hintText: 'Entre Something to do .. ',
                contentPadding: const EdgeInsets.all(16.0)),
          ),
        ),
      );
    }));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Mark "${_todoItems[index]}" as Done ?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('CANCEL'),
              ),
              FlatButton(
                onPressed: () {
                  _removeTodoItem(index);
                  Navigator.of(context).pop();
                },
                child: Text('Mark as Done'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add Task',
        child: Icon(Icons.add),
        
      ),
    );
  }
}
