import 'package:flutter/material.dart';
import 'package:library_management_app/api/constant.dart';

class ButtonField extends StatelessWidget {
  const ButtonField({Key? key, required this.function, required this.text}) : super(key: key);

  final Function function;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: 5, horizontal: 40),
      child: TextButton(
          onPressed: () async{
            function();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: 6, horizontal: 6),
            width: double.infinity,
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'InriaSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
          ),
          style: ButtonStyle(
              shape: MaterialStateProperty.all<
                  RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              backgroundColor: MaterialStateProperty.all(
                  primaryColor))),
    );
  }
}
