import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smile_game/authentication/authentication.dart';
import 'package:smile_game/db/model/user_model.dart';
import 'package:smile_game/db/repository/user_repository.dart';
import 'package:smile_game/ui/root_page/root_state.dart';


class RootCubit extends Cubit<RootState> {
  RootCubit(BuildContext context) : super(RootState.initialState);

  final _userRepository = UserRepository();
  final auth = Authentication();

  void initialize() async {
    if (state.initialized) {
      return;
    }
    await Firebase.initializeApp();
    emit(state.clone(initialized: true));
  }

  void _getUsersByEmail(final String email) {
    _userRepository
        .query(
        spec: MultiQueryTransformer(
            [ComplexWhere('email', isEqualTo: email)]))
        .listen((users) {
      users.isNotEmpty ? _changeCurrentUser(users.first) : null;
    });
  }


  void handleUserLogged(String email) {
    if (state.userLogged) {
      return;
    }
    emit(state.clone(userLogged: true));
    _getUsersByEmail(email);
  }

  bool isUserAvailable() {
    if (state.currentUser == null) {
      return false;
    }
    return true;
  }



  _changeCurrentUser(UserModel user) {
    emit(state.clone(
      currentUser: user,
    ));
  }

  Future<void> handleUserLoggedOut() async {
    await auth.logout();
    emit(RootState.initialState);
  }



}
