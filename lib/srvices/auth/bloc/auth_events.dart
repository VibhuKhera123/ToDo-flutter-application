import 'package:flutter/material.dart';

@immutable
class AuthEvent {
  const AuthEvent();
}

class AuthEventInitilize extends AuthEvent {
  const AuthEventInitilize();
}

class AuthEventSentEmailVerification extends AuthEvent {
  const AuthEventSentEmailVerification();
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;
  const AuthEventRegister(this.email, this.password);
}

class AuthEventShouldRegister extends AuthEvent{
  const AuthEventShouldRegister();
}

class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogIn(this.email, this.password);
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}
