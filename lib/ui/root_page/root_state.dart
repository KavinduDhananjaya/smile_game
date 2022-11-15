import 'package:flutter/material.dart';
import 'package:smile_game/db/model/user_model.dart';

@immutable
class RootState {
  final bool initialized;
  final UserModel? currentUser;
  final bool userLogged;

  const RootState({
    required this.initialized,
    this.currentUser,
    required this.userLogged,
  });

  static RootState get initialState => const RootState(
        initialized: false,
        currentUser: null,
        userLogged: false,
      );

  RootState clone({
    bool? initialized,
    UserModel? currentUser,
    bool? userLogged,
  }) {
    return RootState(
      initialized: initialized ?? this.initialized,
      currentUser: currentUser ?? this.currentUser,
      userLogged: userLogged ?? this.userLogged,
    );
  }
}
