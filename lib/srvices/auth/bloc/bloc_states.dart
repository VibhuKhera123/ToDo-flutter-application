import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/srvices/auth/auth_user.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthStateUninitilized extends AuthState {
  const AuthStateUninitilized();
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering(this.exception);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

class AuthStateNeedVerification extends AuthState {
  const AuthStateNeedVerification();
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  final bool isLoading;
  const AuthStateLoggedOut({
    required this.exception,
    required this.isLoading,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [exception,isLoading];
}
