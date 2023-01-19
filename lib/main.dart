import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/views/login_view.dart';
import 'package:todo_app/views/register_view.dart';
import 'home_page.dart';
import 'views/notes_view.dart';
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