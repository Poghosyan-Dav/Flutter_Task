import 'package:flutter/material.dart';

import '../models/todo.dart';


typedef OnSaveCallback = Function(String task, String note);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Todo? todo;

  const AddEditScreen({
    Key? key,
    required this.onSave,
    required this.isEditing,
    this.todo,
  }) : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _task;
  String? _note;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'edit' : 'add',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.todo!.task : '',
                autofocus: !isEditing,
                style: textTheme.headline5,
                decoration: const InputDecoration(
                  hintText: 'new add ',
                ),
                validator: (val) {
                  return val!.trim().isEmpty ? 'error' : null;
                },
                onSaved: (value) => _task = value!,
              ),
              TextFormField(
                initialValue: isEditing ? widget.todo!.note : '',
                maxLines: 10,
                style: textTheme.subtitle1,
                decoration: const InputDecoration(
                  hintText: 'note',
                ),
                onSaved: (value) => _note = value!,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: isEditing ? 'save' : 'add',
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            widget.onSave(_task!, _note!);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
