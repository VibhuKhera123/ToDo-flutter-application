import 'package:flutter/widgets.dart';
import 'package:todo_app/utilities/dialog/genric_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenricDialog<bool>(
    context: context,
    title: "Log Out",
    content: "Are You Sure You Want To LogOut",
    optionBuilder: () => {
      'Cancel': false,
      'Log Out': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
