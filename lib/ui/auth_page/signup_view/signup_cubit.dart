import 'package:bloc/bloc.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:intl/intl.dart';
import 'package:smile_game/db/repository/user_repository_impl.dart';
import 'package:smile_game/ui/auth_page/signup_view/signup_state.dart';
import '../../../authentication/authentication.dart';
import '../../../db/model/user_model.dart';
import '../../../db/repository/user_repository.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(BuildContext context) : super(SignUpState.initialState);

  final auth = Authentication();
  final userRepo = UserRepository();


  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  Future<void> createUser(
      String email, String password, String confirmPassword) async {
    if (email.isEmpty) {
      errorEvent("Email can`t be Empty");
      emit(state.clone(processing: false));
      return;
    }

    if (!isValidEmail(email)) {
      errorEvent("Please Enter valid Email");
      emit(state.clone(processing: false));
      return;
    }

    final fetchEmail =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

    if (fetchEmail.isNotEmpty) {
      errorEvent("Email is already exist");
      emit(state.clone(processing: false));
      return;
    }

    if (password.length < 6 || password.isEmpty) {
      errorEvent("Password must have minimum 6 characters");
      emit(state.clone(processing: false));
      return;
    }

    if (password != confirmPassword) {
      errorEvent("Please Check the  Password Again...!");
      emit(state.clone(processing: false));
      return;
    }

    try {
      final formatter = DateFormat('dd-MM-yyyy');
      String formattedDate = formatter.format(DateTime.now());

      final register = await auth.register(email, password);

      if (register!.isNotEmpty) {
        final user = UserModel(
          email: email,
          score: 0,
          difficulty: -1,
          rank: -1,
        );

        await userRepo.add(
          item: user,
        );

        emit(state.clone(email: email, registered: true, processing: false));
      }
    } catch (e) {
      emit(state.clone(email: '', registered: false, processing: false));
      return;
    }
  }

  Future<void> signUpUsingGoogle() async {
    try {
      AuthCredential? authUser = await auth.signInWithGoogle();

      emit(state.clone(processing: true));

      if (authUser != null) {
        final UserCredential userCredential =
            await _auth.signInWithCredential(authUser);

        User? user1 = userCredential.user;

        if (user1 != null) {
          final usersList = await userRepo.querySingle(
              spec: MultiQueryTransformer(
                  [ComplexWhere('email', isEqualTo: user1.email)]));

          if (usersList.isNotEmpty) {
            emit(state.clone(processing: false));
            errorEvent('This email is already exist..please login');
            return;
          }

          final formatter = DateFormat('dd-MM-yyyy');
          String formattedDate = formatter.format(DateTime.now());

          final user = UserModel(
            email: user1.email,
            score: 0,
            difficulty: -1,
            rank: -1,
          );

          await userRepo.add(
            item: user,
          );

          emit(state.clone(
              email: user.email, registered: true, processing: false));
        }
      }
    } on FirebaseAuthException catch (e) {
      emit(state.clone(email: '', registered: false, processing: false));

      if (e.code == 'account-exists-with-different-credential') {
        errorEvent('The account already exists with a different credential');
      } else if (e.code == 'invalid-credential') {
        errorEvent('Error occurred while accessing credentials. Try again.');
      }
    } catch (e) {
      print('ERROR ${e}');
      emit(state.clone(email: '', registered: false, processing: false));
      errorEvent('Error occurred using Google Sign In. Try again.');
    }
  }

  signUpUsingFaceBook() async {
    final LoginResult result = await FacebookAuth.i.login();

    if (result.status == LoginStatus.success) {
      try {
        final data = await FacebookAuth.i.getUserData();

        final AuthCredential facebookCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookCredential);

        emit(state.clone(processing: true));

        if (userCredential.user != null) {
          final list = await userRepo.querySingle(
            spec: MultiQueryTransformer(
                [ComplexWhere('email', isEqualTo: userCredential.user!.email)]),
          );

          if (list.isEmpty) {
            final formatter = DateFormat('dd-MM-yyyy');
            String formattedDate = formatter.format(DateTime.now());

            final user = UserModel(
              email: userCredential.user!.email,
              score: 0,
              difficulty: -1,
              rank: -1,
            );

            await userRepo.add(
              item: user,
            );

            emit(state.clone(
                email: user.email, registered: true, processing: false));
          } else {
            emit(state.clone(processing: true));

            errorEvent('This email is already exist..please login');
            await auth.logout();
            return;
          }
        } else {
          emit(state.clone(processing: false));
          errorEvent('The account already exists with a different credential');
          return;
        }
      } on FirebaseAuthException catch (e) {
        emit(state.clone(processing: false));

        if (e.code == 'account-exists-with-different-credential') {
          errorEvent('The account already exists with a different credential');
        } else if (e.code == 'invalid-credential') {
          errorEvent('Error occurred while accessing credentials. Try again.');
        }
      } catch (e) {
        emit(state.clone(processing: false));

        errorEvent('Error occurred using Facebook  SignIn. Try again.');
      }
    } else {
      errorEvent('Error occurred using Facebook  SignIn. Try again.');
    }
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
