import 'package:flutter/cupertino.dart';

import '../model/todo.dart';

class TodoProvider extends ChangeNotifier{
  List<Todo> todoList = [];

  addNewTodo(String title,String description){
    Todo newTodo = Todo(title: title, description: description);
    todoList.add(newTodo);
    notifyListeners();
  }
  deleteTodo(int index){
    todoList.removeAt(index);
    notifyListeners();
  }
}