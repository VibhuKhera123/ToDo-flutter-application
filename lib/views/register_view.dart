import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/routes.dart';

import 'package:todo_app/utilities/show_error_dialog.dart';

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
    return Scaffold(
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

              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                final user = FirebaseAuth.instance.currentUser;
                user?.sendEmailVerification();
                Navigator.of(context).pushNamed(emailverify);
              } on FirebaseAuthException catch (e) {
                switch (e.code) {
                  case "weak-password":
                    await showErrorDialog(
                      context,
                      "Weak Password",
                    );

                    break;
                  case "email-already-in-use":
                    await showErrorDialog(
                      context,
                      "Email already in use",
                    );

                    break;
                  case "invalid-email":
                    await showErrorDialog(
                      context,
                      "Invalid Email",
                    );

                    break;
                  default:
                    await showErrorDialog(
                      context,
                      "Error: ${e.code}",
                    );
                }
              } catch (e) {
                await showErrorDialog(
                  context,
                  e.toString(),
                );
              }
            },
            child: const Text("Register"),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  login,
                  (route) => false,
                );
              },
              child: const Text("Already registered?Log in!!"))
        ],
      ),
    );
  }
}
