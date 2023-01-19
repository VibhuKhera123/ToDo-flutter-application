import 'package:flutter/material.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/srvices/auth/auth_services.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Email")),
      body: Column(
        children: [
          const Text(
              "Please verify your email\nClick the Button if you haave not recieved the email"),
          ElevatedButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
            child: const Text(
              "Send Email Verification",
            ),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              setState(() {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  register,
                  (route) => false,
                );
              });
            },
            child: const Text(
              "Restart",
            ),
          ),
        ],
      ),
    );
  }
}
