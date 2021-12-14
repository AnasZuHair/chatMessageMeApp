import 'package:chat_app_1/scrrens/chat_screen.dart';
import 'package:chat_app_1/scrrens/sign_in.dart';
import 'package:chat_app_1/scrrens/registertion_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'scrrens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MessageMe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const WelcomeScreen(),

      initialRoute: _auth.currentUser != null ? WelcomeScreen.welcomeRoute
      : ChatScrren.chatRoute ,
      routes: {
        WelcomeScreen.welcomeRoute: (context) => const WelcomeScreen(),
        SignInScreen.signInRoute: (context) => const SignInScreen(),
        RegistertionScreen.registerRoute: (context) => const RegistertionScreen(),
        ChatScrren.chatRoute: (context) => const ChatScrren(),
      },
    );
  }
}

