import 'package:flutter/material.dart';
import 'package:smile_game/db/model/user_model.dart';

@immutable
class HomePageState {
  final String? currentQuestionImage;
  final int? currentAnswer;
  final int score;
  final bool isProcessing;
  final String error;
  final int currentLevel;
  final int currentIndex;

  const HomePageState({
    this.currentAnswer,
    required this.currentQuestionImage,
    required this.score,
    required this.isProcessing,
    required this.error,
    required this.currentIndex,
    required this.currentLevel,
  });

  static HomePageState get initialState => const HomePageState(
        currentQuestionImage: '',
        score: 0,
        isProcessing: false,
        error: "",
        currentLevel: 1,
        currentIndex: 1,
      );

  HomePageState clone({
    String? currentQuestionImage,
    String? error,
    int? currentAnswer,
    int? score,
    bool? isProcessing,
    int? currentLevel,
    int? currentIndex,
  }) {
    return HomePageState(
      currentQuestionImage: currentQuestionImage ?? this.currentQuestionImage,
      currentAnswer: currentAnswer ?? this.currentAnswer,
      score: score ?? this.score,
      isProcessing: isProcessing ?? this.isProcessing,
      error: error ?? this.error,
      currentIndex: currentIndex ?? this.currentIndex,
      currentLevel: currentLevel ?? this.currentLevel,
    );
  }
}
