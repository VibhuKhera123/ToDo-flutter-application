import 'package:flutter/material.dart';
import 'package:todo_app/utilities/dialog/genric_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenricDialog<void>(
    context: context,
    title: 'Shearing',
    content: "You cannot share an empty note",
    optionBuilder: () => {
      'OK': null,
    },
  );
}
