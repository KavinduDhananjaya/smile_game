import 'dart:async';
import 'dart:convert' as convert;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smile_game/db/repository/smile_api_repository_impl.dart';
import 'package:smile_game/db/repository/user_repository.dart';
import 'package:smile_game/ui/home_page/home_page_state.dart';
import 'package:smile_game/ui/root_page/root_cubit.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(BuildContext context, this.isFirstTime)
      : rootCubit = BlocProvider.of(context),
        super(HomePageState.initialState) {

    emit(state.clone(
      score: rootCubit.state.currentUser?.score,
      currentIndex: rootCubit.state.currentUser?.played,
      currentLevel: rootCubit.state.currentUser?.level,
    ));

    if(!isFirstTime){
      getQuestionData(true);
    }

    // rootBlocListener();
  }

  final _userRepository = UserRepository();

  final bool isFirstTime;

  late Timer _timer;
  final RootCubit rootCubit;

  final _apiRepository = SmileApiRepositoryImpl();

  rootBlocListener() {
    rootCubit.stream.listen((event) {
      emit(state.clone(
        score: event.currentUser?.score,
        currentIndex: event.currentUser?.played,
        currentLevel: event.currentUser?.level,
      ));
    });
  }

  setDifficulty(int diff) async {
    if (diff > -1) {
      emit(state.clone(difficulty: diff));

      await _userRepository.update(
          item: rootCubit.state.currentUser!,
          mapper: (_) => {'difficulty': diff},
          parent: rootCubit.state.currentUser?.ref);
    }
  }

  void timeOut() {
    getQuestionData(false);
    updateLevel();
  }

  getQuestionData(bool isStart) async {
    try {
      emit(state.clone(isProcessing: true, isTimeOut: false));

      final response = await _apiRepository.getData();

      if (response.statusCode == 200) {
        final jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;

        final question = jsonResponse['question'] ?? '';
        final answer = jsonResponse['solution'] ?? 0;

        await setAnswers(answer);
        await setQuestionImage(question);

        emit(state.clone(isProcessing: false, isClicked: false, isCorrect: -1));
        startTimer();
      } else {
        emit(state.clone(isProcessing: false, isClicked: false, isCorrect: -1));
        await setAnswers(0);
        await setQuestionImage('');
      }
    } catch (e) {
      emit(state.clone(isProcessing: false, isClicked: false, isCorrect: -1));
      await setAnswers(0);
      await setQuestionImage('');

      getQuestionData(false);
    }
  }

  setQuestionImage(String image) {
    emit(state.clone(currentQuestionImage: image));
  }

  setAnswers(int correctAnswer) {
    emit(state.clone(currentAnswer: correctAnswer));
  }

  startTimer() {
    if (state.difficulty == 0) {
      emit(state.clone(initialTime: 30, time: 30));
    } else if (state.difficulty == 1) {
      emit(state.clone(initialTime: 20, time: 20));
    } else if (state.difficulty == 2) {
      emit(state.clone(initialTime: 10, time: 10));
    }
    const oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (state.time == 0) {
          timer.cancel();
          emit(state.clone(time: 0, isTimeOut: true));
        } else {
          final i = (state.time - 1);
          emit(state.clone(time: i.toDouble()));
        }
      },
    );
  }

  checkAnswer(int i) async {
    _timer.cancel();
    emit(state.clone(isClicked: true,isLevelComplete: false));

    if (state.isCorrect == -1) {
      if (i == state.currentAnswer) {
        emit(state.clone(isCorrect: 0));

        await _userRepository.update(
          item: rootCubit.state.currentUser!,
          mapper: (_) => {
            'score': state.score + 10,
          },
          parent: rootCubit.state.currentUser?.ref,
        );
        emit(state.clone(score: state.score + 10));
      } else {
        emit(state.clone(isCorrect: 1));
      }
    }
  }


  Future<void> nextLevel() async {
    emit(state.clone(isLevelComplete: false));

  }

  Future<void> updateLevel() async {
    emit(state.clone(isLevelComplete: false));
    int? currentLevel = state.currentLevel;
    int? currentIndex = state.currentIndex;

    if (currentIndex != 5) {
      currentIndex = currentIndex + 1;
    } else if (currentIndex == 5 && currentLevel >= 0) {
      currentIndex = 1;
      currentLevel = currentLevel + 1;
      emit(state.clone(isLevelComplete: true));
    }

    await _userRepository.update(
      item: rootCubit.state.currentUser!,
      mapper: (_) => {
        'level': currentLevel,
        'played': currentIndex,
      },
      parent: rootCubit.state.currentUser?.ref,
    );

    emit(state.clone(currentLevel: currentLevel, currentIndex: currentIndex));
  }

  void closeTimer() {
    _timer.isActive ? _timer.cancel() : null;
  }

  @override
  Future<void> close() {
    _timer.isActive ? _timer.cancel() : null;
    return super.close();
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    _addErr(error);
    super.onError(error, stackTrace);
  }

  void _addErr(e) {
    if (e is StateError) {
      return;
    }
    try {
      errorEvent(
        (e is String)
            ? e
            : (e.message ?? "Something went wrong. Please try again !"),
      );
    } catch (e) {
      errorEvent("Something went wrong. Please try again !");
    }
  }

  void errorEvent(String error) {
    emit(state.clone(error: ''));
    emit(state.clone(error: error));
  }
}
