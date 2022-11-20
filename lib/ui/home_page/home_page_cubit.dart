import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:smile_game/authentication/authentication.dart';
import 'package:smile_game/db/repository/smile_api_repository_impl.dart';
import 'package:smile_game/db/repository/user_repository.dart';
import 'package:smile_game/ui/auth_page/login_page/login_state.dart';
import 'package:smile_game/ui/home_page/home_page_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:smile_game/ui/root_page/root_cubit.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(BuildContext context)
      : rootCubit = BlocProvider.of(context),
        super(HomePageState.initialState) {

    emit(state.clone(score: rootCubit.state.currentUser?.score));
    getQuestionData(true);
    rootCubit.stream.listen((event) {
      emit(state.clone(score: event.currentUser?.score));
    });
  }

  final _userRepository = UserRepository();

  late Timer _timer;
  final RootCubit rootCubit;

  final _apiRepository=SmileApiRepositoryImpl();

  setDifficulty(int diff) async {
    if (diff > -1) {
      emit(state.clone(difficulty: diff));

      await _userRepository.update(
          item: rootCubit.state.currentUser!,
          mapper: (_) => {'difficulty': diff},
          parent: rootCubit.state.currentUser?.ref);

    }
  }

  getQuestionData(bool isStart) async {
    try {
      emit(state.clone(isProcessing: true,isTimeOut: false));
      // final url =
      //     Uri.https('marcconrad.com', '/uob/smile/api.php', {'q': '{https}'});
      //
      // final response = await http.get(url);

      final response=await _apiRepository.getData();

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
          emit(state.clone(time: 0,isTimeOut: true));
        } else {
          final i = (state.time - 1);
          emit(state.clone(time: i.toDouble()));
        }
      },
    );
  }

  checkAnswer(int i) async {
    _timer.cancel();
    emit(state.clone(isClicked: true));

    if (state.isCorrect == -1) {
      if (i == state.currentAnswer) {
        emit(state.clone(isCorrect: 0));

        await _userRepository.update(
            item: rootCubit.state.currentUser!,
            mapper: (_) => {'score': state.score + 10},
            parent: rootCubit.state.currentUser?.ref);
      } else {
        emit(state.clone(isCorrect: 1));


      }
    }
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
