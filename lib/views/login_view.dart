import 'package:flutter/material.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/srvices/auth/auth_exceptions.dart';
import 'package:todo_app/srvices/auth/auth_services.dart';
import 'package:todo_app/utilities/dialog/error_dialog.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log In"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: const InputDecoration(
              hintText: "Enter your email",
              labelText: "Email",
            ),
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: _password,
            decoration: const InputDecoration(
              hintText: "Enter your password",
              labelText: "Password",
            ),
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(register, (route) => false);
            },
            child: const Text("Register"),
          ),
          ElevatedButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try {
                await AuthService.firebase().login(
                  email: email,
                  password: password,
                );

                setState(() {
                  Navigator.pushNamed(context, homepage);
                });
              } on UserNotFoundAuthException {
                await showErrorDialog(
                  context,
                  "User Not Found",
                );
              } on WrongPasswordAuthException {
                await showErrorDialog(
                  context,
                  "Incorrect Password!",
                );
              } on GenricAuthException {
                await showErrorDialog(
                  context,
                  'Authentication Error',
                );
              }
            },
            child: const Text("Log In"),
          )
        ],
      ),
    );
  }
}
