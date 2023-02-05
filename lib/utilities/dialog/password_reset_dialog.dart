import 'package:flutter/widgets.dart';
import 'package:todo_app/utilities/dialog/genric_dialog.dart';

Future<void> showPasswordResetSendDialog(BuildContext context) {
  return showGenricDialog(
    context: context,
    title: 'Password Reset',
    content: 'Please check your email for reset password link',
    optionBuilder: () => {
      'OK': null,
    },
  );
}
