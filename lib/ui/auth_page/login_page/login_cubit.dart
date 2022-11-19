import 'package:bloc/bloc.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:smile_game/authentication/authentication.dart';
import 'package:smile_game/db/repository/user_repository.dart';
import 'package:smile_game/ui/auth_page/login_page/login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit(BuildContext context) : super(LoginState.initialState);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _authentication = Authentication();
  final _userRepository = UserRepository();

  bool isValidEmail(String email) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
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

  Future<void> userLogin(String emails, String password) async {
    try {

      emit(state.clone(processing: true));

      if (isValidEmail(emails)) {

        final fetchEmail =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(emails);

        if (fetchEmail.isEmpty) {
          emit(state.clone(error: "User does not exist.Please SignUp."));
          return;
        }

        if(fetchEmail.first=="google.com"){
          errorEvent('The account already exists with a google account..please login using google');
          return;
        }

        if(fetchEmail.first=="facebook.com"){
          errorEvent('The account already exists with a facebook account..please login using facebook');
          return;
        }

        final dbUser = await _userRepository.querySingle(
            spec: MultiQueryTransformer(
                [ComplexWhere('email', isEqualTo: emails)]));


        if (dbUser.isNotEmpty) {
          final userEmail = await _authentication.login(emails, password);

          if (userEmail!.isNotEmpty) {
            emit(state.clone(email: userEmail, error: ""));
          }
        } else {
          emit(state.clone(processing: false));
          errorEvent('Sorry..Something went wrong. Please contact us..');
          return;
        }
      } else {
        emit(state.clone(error: "Invalid Email...Please Try Again"));
        return;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(state.clone(error: "No user found for that email."));
        return;
      } else if (e.code == 'wrong-password') {
        emit(state.clone(error: "Wrong password provided for that user."));
        return;
      }
    }
  }

  Future<void> googleLogin() async {
    try {
      AuthCredential? credential = await _authentication.signInWithGoogle();

      if (credential != null) {
        final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
        User? user = userCredential.user;
        emit(state.clone(processing: true));
        if (user != null) {
          final dbUser = await _userRepository.querySingle(
              spec: MultiQueryTransformer(
                  [ComplexWhere('email', isEqualTo: user.email)]));

          if (dbUser.isEmpty) {
            emit(state.clone(processing: false));
            errorEvent('Sorry..Cant find your account. Please SignUp.');
            await _authentication.logout();
          } else {
            emit(state.clone(email: user.email, error: ""));
          }
        }
        emit(state.clone(processing: false));
      }
    } on FirebaseAuthException catch (e) {
      emit(state.clone(processing: false));

      if (e.code == 'account-exists-with-different-credential') {
        emit(state.clone(processing: false));
        errorEvent('The account already exists with a different credential');
        return;
      } else if (e.code == 'invalid-credential') {
        emit(state.clone(processing: false));
        errorEvent('Error occurred while accessing credentials. Try again.');
        return;
      }
    } catch (e) {
      emit(state.clone(processing: false));
      errorEvent('Error occurred using Google Sign In. Try again.');
    }
  }

  facebookLogin() async {
    final LoginResult result = await FacebookAuth.i.login();

    if (result.status == LoginStatus.success) {
      try {
        final AuthCredential facebookCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);

        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookCredential);

        if (userCredential.user != null) {
          emit(state.clone(processing: true));

          final list = await _userRepository.querySingle(
            spec: MultiQueryTransformer(
                [ComplexWhere('email', isEqualTo: userCredential.user!.email)]),
          );

          if (list.isNotEmpty) {
            emit(state.clone(
                email: userCredential.user!.email,
                error: "",
                processing: false));
          } else {
            emit(state.clone(processing: false));
            await _authentication.logout();
            errorEvent('Sorry..Cant find your account. Please SignUp.');

            return;
          }
        } else {
          emit(state.clone(processing: false));
          errorEvent('Error occurred using Facebook  SignIn. Try again.');
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
      emit(state.clone(processing: false));
      errorEvent('Error occurred using Facebook  SignIn. Try again.');
    }
  }

  restPassword(String email) async {
    if (isValidEmail(email)) {
      final fetchEmail =
      await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      if (fetchEmail.isEmpty) {
        errorEvent("Invalid Email...Please Try Again");
        return;
      }
      try {
        await _authentication.sendPasswordResetEmail(email);
      } catch (e) {
        errorEvent("Invalid Email...Please Try Again");
      }
    } else {
      errorEvent("Invalid Email...Please Try Again");
      return;
    }
  }
}
