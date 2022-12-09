import 'package:flutter/material.dart';

@immutable
class LoginState {
  final String error;
  final String email;
  final bool processing;

  LoginState({
    required this.error,
    required this.email,
    required this.processing,
  });

  LoginState clone({
    String? error,
    String? email,
    bool? processing,
  }) {
    return LoginState(
      error: error ?? this.error,
      email: email ?? this.email,
      processing: processing ?? this.processing,
    );
  }

  static LoginState get initialState => LoginState(
    error: "",
    email: "",
    processing: false,
  );
}
