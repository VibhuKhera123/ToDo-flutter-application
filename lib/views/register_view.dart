import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/srvices/auth/auth_exceptions.dart';
import 'package:todo_app/srvices/auth/bloc/auth_bloc.dart';
import 'package:todo_app/srvices/auth/bloc/auth_events.dart';
import 'package:todo_app/srvices/auth/bloc/bloc_states.dart';
import 'package:todo_app/utilities/dialog/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(context, 'Weak Password');
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(context,
                'Email already in use! Try Logging In or change email');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Invalid Email');
          } else if (state.exception is GenricAuthException) {
            await showErrorDialog(context, 'Faild To Register');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Register")),
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
            ElevatedButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;

                context.read<AuthBloc>().add(AuthEventRegister(
                      email,
                      password,
                    ));
              },
              child: const Text("Register"),
            ),
            TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventLogOut(),
                      );
                },
                child: const Text("Already registered?Log in!!"))
          ],
        ),
      ),
    );
  }
}
