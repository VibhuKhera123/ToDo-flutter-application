import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/srvices/auth/auth_services.dart';
import 'package:todo_app/srvices/auth/bloc/auth_bloc.dart';
import 'package:todo_app/srvices/auth/bloc/auth_events.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
                "Please verify your email\nClick the Button if you haave not recieved the email"),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                context.read<AuthBloc>().add(
                      const AuthEventSentEmailVerification(),
                    );
              },
              child: const Text(
                "Send Email Verification",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                context.read<AuthBloc>().add(
                      const AuthEventLogOut(),
                    );
              },
              child: const Text(
                "Restart",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
