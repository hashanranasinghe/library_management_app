import 'package:flutter/material.dart';
import 'package:library_management_app/api/constant.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;

  final String? text;
  final TextInputType textInputType;
  final IconData? iconData;
  final Function(String)? function;
  final String? detail;

  const InputField({
    Key? key,
    required this.controller,
    this.text,
    required this.textInputType,
    this.function,
    this.detail,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        textInputAction: TextInputAction.next,
        validator: (value) {
          return function!(value!);
        },
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          prefixIcon: iconData != null
              ? Icon(
                  iconData,
                  color: primaryColor,
                )
              : null,
          filled: true,
          fillColor: Color(0xFFE3E3E3FF),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color(0xFFE3E3E3FF), width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color(0xFFE3E3E3FF), width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFFCE0326), width: 2.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color(0xFFE3E3E3FF), width: 1.0),
          ),
          prefix: Padding(
            padding: EdgeInsets.only(left: 10),
          ),
          contentPadding: const EdgeInsets.all(5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color(0xFFE3E3E3FF), width: 1.0),
          ),
          hintStyle: TextStyle(fontWeight: FontWeight.bold),
          hintText: text,
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
    );
  }
}
