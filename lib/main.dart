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
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // final user = FirebaseAuth.instance.currentUser;
              // final emailVerified = user?.emailVerified ?? false;
              // if (emailVerified) {

              // } else {
              //   return VerifyEmailView();
              // }

              // print(user);
              // return const Text("done");
              return LoginView();
            default:
              return CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}
