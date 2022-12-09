import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static late Authentication _authentication;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///use factory design pattern
  factory Authentication() {
    _authentication = Authentication._internal();
    return _authentication;
  }

  Authentication._internal();

  /// Attempts to sign in a user with the given email address and password.

  Future<String?> login(String email, String password) async {
    final UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user?.email;
  }

  /// Triggers the Firebase Authentication backend to send a password-reset
  /// email to the given email address, which must correspond to an existing
  /// user of your app.

  Future<void> sendPasswordResetEmail(String email) async {
    _auth.sendPasswordResetEmail(email: email);
  }

  /// Method to create a new user account with the given email address and password.
  /// it creates new use in authentication table.

  Future<String?> register(String email, String password) async {
    final UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user?.email;
  }

  Future<void> logout() async {
    return await _auth.signOut();
  }

  /// Returns the current [User] if they are currently signed-in, or `null` if
  /// not.
  Future<User?> getLoggedUser() async {
    final User? user = _auth.currentUser;
    if (user == null) return null;
    return user;
  }

  Future<void> changePassword(String password) async {
    User? user = _auth.currentUser;
    user?.updatePassword(password).then((_) async {
      print("Successfully changed password");
      await logout();
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
  }

  Future<void> changeEmail(String email) async {
    User? user = _auth.currentUser;
    user?.updateEmail(email).then((_) {
      print("Successfully changed email");
    }).catchError((error) {
      print("email can't be changed" + error.toString());
    });
    return null;
  }

  Future<AuthCredential?> signInWithGoogle() async {
    AuthCredential? credential;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {

      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      return credential;
    }

    return credential;
  }
}
