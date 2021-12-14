import 'package:flutter/material.dart';


class MyEditText extends StatelessWidget {
  final String text;

  const MyEditText({
    Key? key,required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return TextField(
     textAlign: TextAlign.left,
     onChanged: (value){

     },
     decoration: InputDecoration(
       hintText: text,
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
            );
  }
}