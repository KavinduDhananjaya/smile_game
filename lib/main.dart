import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smile_game/authentication/authentication.dart';
import 'package:smile_game/ui/smile_game_app_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );

  final user = await Authentication().getLoggedUser();
  runApp(
     SmileGameAppView(user?.email),
  );
}
