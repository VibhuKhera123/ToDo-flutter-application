import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/srvices/auth/bloc/auth_bloc.dart';
import 'package:todo_app/srvices/auth/firebase_auth_provider.dart';
import 'package:todo_app/views/login_view.dart';
import 'package:todo_app/views/notesView/create_update_notes_view.dart';
import 'package:todo_app/views/register_view.dart';
import 'views/home_page.dart';
import 'views/notesView/notes_view.dart';
import 'views/verify_email_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home:  BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(FirebaseAuthProvider()),
      child: const HomePage(),
    ),
    routes: {
      login: (context) => const LoginView(),
      register: (context) => const RegisterView(),
      homepage: (context) => const HomePage(),
      emailverify: (context) => const VerifyEmailView(),
      noteView: (context) => const NotesView(),
      createUpdateNote: (context) => const CreateUpdateNoteView(),
    },
  ));
}
