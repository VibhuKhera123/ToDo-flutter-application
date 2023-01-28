import 'package:flutter/widgets.dart';
import 'package:todo_app/utilities/dialog/genric_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenricDialog(
    context: context,
    title: 'An Error Occured',
    content: text,
    optionBuilder: () => {
      'OK':null,
    },
  );
}
