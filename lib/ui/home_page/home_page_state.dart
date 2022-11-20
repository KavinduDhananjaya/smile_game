import 'package:flutter/material.dart';

@immutable
class HomePageState {
  final String currentQuestionImage;
  final int currentAnswer;
  final int score;
  final bool isProcessing;
  final String error;
  final int currentLevel;
  final int currentIndex;
  final int difficulty;
  final double time;
  final int initialTime;
  final bool isClicked;
  final bool isTimeOut;
  final int isCorrect;

  const HomePageState({
    required this.currentAnswer,
    required this.currentQuestionImage,
    required this.score,
    required this.isProcessing,
    required this.error,
    required this.currentIndex,
    required this.currentLevel,
    required this.difficulty,
    required this.time,
    required this.initialTime,
    required this.isClicked,
    required this.isCorrect,
    required this.isTimeOut,
  });

  static HomePageState get initialState => const HomePageState(
        currentQuestionImage: '',
        score: 0,
        isProcessing: false,
        error: "",
        currentLevel: 1,
        currentIndex: 1,
        difficulty: 0,
        time: 1,
        initialTime: 30,
        currentAnswer: -1,
        isClicked: false,
        isCorrect: -1,
        isTimeOut: false,
      );

  HomePageState clone({
    String? currentQuestionImage,
    String? error,
    int? currentAnswer,
    int? score,
    bool? isProcessing,
    int? currentLevel,
    int? currentIndex,
    int? difficulty,
    double? time,
    int? initialTime,
    bool? isClicked,
    bool? isTimeOut,
    int? isCorrect,
  }) {
    return HomePageState(
      currentQuestionImage: currentQuestionImage ?? this.currentQuestionImage,
      currentAnswer: currentAnswer ?? this.currentAnswer,
      score: score ?? this.score,
      isProcessing: isProcessing ?? this.isProcessing,
      error: error ?? this.error,
      currentIndex: currentIndex ?? this.currentIndex,
      currentLevel: currentLevel ?? this.currentLevel,
      difficulty: difficulty ?? this.difficulty,
      time: time ?? this.time,
      initialTime: initialTime ?? this.initialTime,
      isClicked: isClicked ?? this.isClicked,
      isCorrect: isCorrect ?? this.isCorrect,
      isTimeOut: isTimeOut ?? this.isTimeOut,
    );
  }
}
