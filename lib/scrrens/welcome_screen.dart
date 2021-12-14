import 'package:chat_app_1/scrrens/sign_in.dart';
import 'package:chat_app_1/scrrens/registertion_screen.dart';
import 'package:chat_app_1/widget/my_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String welcomeRoute = 'welcomeRoute';
  const WelcomeScreen({ Key? key }) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  child: Image.asset('images/logo.png'),
                ),
                const Text(
                  'MessageMe',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2e386b),
                  ),),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            MyButton(
              textButton: 'Sign In',
              onPressed: (){
                Navigator.pushNamed(context,SignInScreen.signInRoute);
              },
              colorText: const Color(0xff2e386b),
              colorButton:  Colors.yellow[900]!,
            ),
            MyButton(
              textButton: 'Register',
              onPressed: (){
                Navigator.pushNamed(context, RegistertionScreen.registerRoute);
              },
              colorText: Colors.yellow[900]! ,
              colorButton: const Color(0xff2e386b),
            ),
          ],
        ),
      ),
    );
  }
}
