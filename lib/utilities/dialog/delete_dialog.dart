import 'package:flutter/widgets.dart';
import 'package:todo_app/utilities/dialog/genric_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenricDialog<bool>(
    context: context,
    title: "Delete Note",
    content: "Are You Sure You Want To Delete The Note",
    optionBuilder: () => {
      'Cancel': false,
      'Delete': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
