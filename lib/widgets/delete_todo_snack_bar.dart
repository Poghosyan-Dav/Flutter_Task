import 'package:flutter/material.dart';
import 'package:flutter_challenge_todo_app/models/todo.dart';


class DeleteTodoSnackBar extends SnackBar {
  DeleteTodoSnackBar({
    Key? key,
    required Todo todo,
    required VoidCallback onUndo,
  }) : super(
          key: key,
          content: const Text(
            'delete',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'undo',
            onPressed: onUndo,
          ),
        );
}
