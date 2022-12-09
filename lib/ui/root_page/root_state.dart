import 'package:flutter/material.dart';
import 'package:smile_game/db/model/user_model.dart';

@immutable
class RootState {
  final bool initialized;
  final UserModel? currentUser;
  final bool userLogged;
  final int score;
  final bool isProcessing;
  final int rank;
  final List<UserModel> usersScores;

  const RootState({
    required this.initialized,
    this.currentUser,
    required this.userLogged,
    required this.score,
    required this.isProcessing,
    required this.usersScores,
    required this.rank,
  });

  static RootState get initialState => const RootState(
        initialized: false,
        currentUser: null,
        userLogged: false,
        score: 0,
        isProcessing: false,
        usersScores: [],
        rank: -1,
      );

  RootState clone({
    bool? initialized,
    UserModel? currentUser,
    bool? userLogged,
    int? score,
    bool? isProcessing,
    int? rank,
    List<UserModel>? usersScores,
  }) {
    return RootState(
      initialized: initialized ?? this.initialized,
      currentUser: currentUser ?? this.currentUser,
      userLogged: userLogged ?? this.userLogged,
      score: score ?? this.score,
      isProcessing: isProcessing ?? this.isProcessing,
      rank: rank ?? this.rank,
      usersScores: usersScores ?? this.usersScores,
    );
  }
}
