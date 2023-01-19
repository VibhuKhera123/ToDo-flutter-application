import 'package:flutter/material.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/srvices/auth/auth_services.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes View"),
        actions: [
          IconButton(
            onPressed: () async {
              final shouldlogout = await showLogOutDialog(context);
              if (shouldlogout) {
                await AuthService.firebase().logOut();
                setState(() {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(login, (_) => false);
                });
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: const Text("Confirm Log Out"),
          content: const Text('Are you sure you want to Log Out'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Log Out"))
          ],
        );
      })).then((value) => value ?? false);
}
