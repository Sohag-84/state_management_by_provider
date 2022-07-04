// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/provider/todo_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo list"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: todos.todoList.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: ListTile(
                  title: Text(
                    todos.todoList[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(todos.todoList[index].description),
                  trailing: IconButton(
                    onPressed: () {
                      todos.deleteTodo(index);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: SizedBox(
                    height: 300,
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18, top: 10),
                        child: Column(
                          children: [
                            Text(
                              "Add Todo",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: _titleController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "required";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(labelText: "title"),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _descController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "required";
                                } else {
                                  return null;
                                }
                              },
                              decoration:
                                  InputDecoration(labelText: "description"),
                            ),
                            SizedBox(height: 15),
                            InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  final title = _titleController.text;
                                  final description = _descController.text;
                                  todos.addNewTodo(title, description);
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                height: 34,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  "Add",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
