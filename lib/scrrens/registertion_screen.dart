import 'package:chat_app_1/scrrens/chat_screen.dart';
import 'package:chat_app_1/widget/my_button.dart';
import 'package:chat_app_1/widget/my_edit_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistertionScreen extends StatefulWidget {
  static const String registerRoute = 'registerRouet';
  const RegistertionScreen({ Key? key }) : super(key: key);

  @override
  _RegistertionScreenState createState() => _RegistertionScreenState();
}

class _RegistertionScreenState extends State<RegistertionScreen> {
  bool _saving = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 100,
                child: Image.asset('images/logo.png'),
              ),
              const SizedBox(height: 5,),
              const Text(
                'Register',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2e386b),
                ),
                ),
              const SizedBox(height: 10,),
              TextField(
                keyboardType: TextInputType.emailAddress,
           textAlign: TextAlign.left,
           onChanged: (value){
         email = value;
           },
           decoration: InputDecoration(
         hintText: 'Enter your email',
         contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
         border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(12),
         ),
         enabledBorder: OutlineInputBorder(
           borderSide:  BorderSide(color:   Colors.yellow[900]!,width: 1),
           borderRadius: BorderRadius.circular(12),
         ),
         focusedBorder: OutlineInputBorder(
           borderSide: const  BorderSide(color:  Color(0xff2e386b),width: 3),
           borderRadius: BorderRadius.circular(12),
         ),
           ),
              ),
              const SizedBox(height: 10,),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
           textAlign: TextAlign.left,
           onChanged: (value){
         password = value;
           },
           decoration: InputDecoration(
         hintText: 'Enter your password',
         contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
         border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(12),
         ),
         enabledBorder: OutlineInputBorder(
           borderSide:  BorderSide(color:   Colors.yellow[900]!,width: 1),
           borderRadius: BorderRadius.circular(12),
         ),
         focusedBorder: OutlineInputBorder(
           borderSide: const  BorderSide(color:  Color(0xff2e386b),width: 3),
           borderRadius: BorderRadius.circular(12),
         ),
           ),
              ),
              const SizedBox(height: 10,),
              MyButton(
                textButton: 'Register',
                onPressed: () async{
                  setState(() {
                    _saving = true;
                  });
                    try{
                      final newUser = await _auth.
                  createUserWithEmailAndPassword(
                    email: email,
                    password: password);
                    Navigator.pushNamed(context, ChatScrren.chatRoute);
                    setState(() {
                      _saving = false;
                    });
                    } catch (e){
                      print(e);
                    }
                },
                colorText: Colors.yellow[900]!,
                colorButton: const Color(0xff2e386b)
                ),
      
            ],
          ),
        ),
      ),
      
      );
  }
}
