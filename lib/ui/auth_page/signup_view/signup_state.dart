
import 'package:flutter/material.dart';

@immutable
class SignUpState {
  final String error;
  final bool processing;
  final bool registered;
  final String email;
  final int role;

  const SignUpState({
    required this.error,
    required this.processing,
    required this.registered,
    required this.role,
    required this.email,
  });

  static SignUpState get initialState => const SignUpState(
    error: '',
    processing: false,
    registered: false,
    role: 0,
    email: '',
  );

  SignUpState clone({
    String? error,
    bool? processing,
    bool? registered,
    int ?role,
    String ?email,
  }) {
    return SignUpState(
      error: error ?? this.error,
      registered: registered ?? this.registered,
      processing: processing ?? this.processing,
      role: role ?? this.role,
      email: email ?? this.email,
    );
  }
}
