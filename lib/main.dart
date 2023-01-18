import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/views/login_view.dart';
import 'package:todo_app/views/register_view.dart';
import 'views/verify_email_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    initialRoute: '/home/',
    routes: {
      login: (context) => const LoginView(),
      register: (context) => const RegisterView(),
      homepage: (context) => const HomePage(),
      emailverify: (context) => const VerifyEmailView(),
      noteView:(context) => const NotesView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.emailVerified) {
                  return const NotesView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }
            default:
              return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}

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
                await FirebaseAuth.instance.signOut();
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
