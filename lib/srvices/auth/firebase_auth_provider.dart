import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/firebase_options.dart';

import 'auth_exceptions.dart';
import 'auth_provider.dart';
import 'auth_user.dart';

import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLogedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "weak-password":
          throw WeakPasswordAuthException();

        case "email-already-in-use":
          throw EmailAlreadyInUseAuthException();

        case "invalid-email":
          throw InvalidEmailAuthException();
        default:
          throw GenricAuthException();
      }
    } catch (_) {
      throw GenricAuthException();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromfirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLogedInAuthException();
    }
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLogedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          throw UserNotFoundAuthException();
        case "wrong-password":
          throw WrongPasswordAuthException();
        default:
          throw GenricAuthException();
      }
    } catch (_) {
      throw GenricAuthException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLogedInAuthException();
    }
  }

  @override
  Future<void> initilize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'firebase_auth/invalid-email':
          throw InvalidEmailAuthException();
        case 'firebse_auth/user-not-found':
          throw UserNotFoundAuthException();
        default:
          throw GenricAuthException();
      }
    } catch (_) {
      throw GenricAuthException();
    }
  }
}
