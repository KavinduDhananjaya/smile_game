import 'package:flutter/material.dart';
import 'package:smile_game/db/model/user_model.dart';

@immutable
class RootState {
  final bool initialized;
  final UserModel? currentUser;
  final bool userLogged;
  final String currentQuestionImage;
  final int? currentAnswer;
  final int score;
  final bool isProcessing;

  const RootState({
    required this.initialized,
    this.currentUser,
    this.currentAnswer,
    required this.userLogged,
    required this.currentQuestionImage,
    required this.score,
    required this.isProcessing,
  });

  static RootState get initialState => const RootState(
        initialized: false,
        currentUser: null,
        userLogged: false,
        currentQuestionImage: '',
        score: 0,
        isProcessing: false,
      );

  RootState clone({
    bool? initialized,
    UserModel? currentUser,
    bool? userLogged,
    String? currentQuestionImage,
    int? currentAnswer,
    int? score,
    bool? isProcessing,
  }) {
    return RootState(
      initialized: initialized ?? this.initialized,
      currentUser: currentUser ?? this.currentUser,
      userLogged: userLogged ?? this.userLogged,
      currentQuestionImage: currentQuestionImage ?? this.currentQuestionImage,
      currentAnswer: currentAnswer ?? this.currentAnswer,
      score: score ?? this.score,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}
