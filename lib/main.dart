import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'registration.dart';
import 'todo_list.dart';
import 'tools.dart';
import 'splash_screen.dart';

void main() {
  firebasePlayground();
  runApp(const MyApp());
}

Future<void> firebasePlayground() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  dprint('fb initializeApp');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wow za',
      theme: ThemeData(
          primarySwatch: Palette.primaryMate,
          primaryColorDark: Palette.primaryMate,
          primaryColorLight: Palette.textMate,
          backgroundColor: Palette.contrastMate),
      home: const SplashScreen(),
      // home: const Registration(),
      routes: {
        "Splash": (context) => const SplashScreen(),
        "Login": (context) => const LoginPage(),
        "TodoList": (context) => const TodoList(),
        "Registration": (context) => const Registration(),
      },
    );
  }
}
