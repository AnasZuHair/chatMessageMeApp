import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  final String textButton;
  final VoidCallback onPressed;
  final Color colorText;
  final Color colorButton;
  const MyButton({
    Key? key,required this.textButton,required this.onPressed,required this.colorText,required this.colorButton
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 7,
        color: colorButton,
        borderRadius: BorderRadius.circular(15),
        child: MaterialButton(
          highlightColor: Colors.white,
          splashColor: Colors.white,
          onPressed: onPressed,
          minWidth: 200,
          height: 50,
          child:  Text(
            textButton,
            style:  TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorText,
            ),
            ),
        ),
      ),
    );
  }
}