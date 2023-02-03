import 'package:flutter/material.dart';

@immutable
class AuthEvent {
  const AuthEvent();
}

class AuthEventInitilize extends AuthEvent {
  const AuthEventInitilize();
}

class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogIn(this.email, this.password);
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}
