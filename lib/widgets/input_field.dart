import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;

  final String? text;
  final TextInputType textInputType;

  final Function(String)? function;
  final String? detail;

  const InputField({
    Key? key,
    required this.controller,

    this.text,
    required this.textInputType,
    this.function,
    this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        textInputAction: TextInputAction.next,
        validator: (value){
          return function!(value!);
        },
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          prefix: Padding(
            padding: EdgeInsets.only(left: 10),
          ),
          contentPadding: const EdgeInsets.all(5),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red,width: 2.0),
          ),
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold
          ),
          hintText: text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),),
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
    );
  }
}
