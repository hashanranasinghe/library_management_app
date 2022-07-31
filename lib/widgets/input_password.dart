import 'package:flutter/material.dart';
import 'package:library_management_app/api/constant.dart';

class InputPasswordField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final String? text;
  final Function(String)? function;

  InputPasswordField(
      {Key? key, this.textEditingController, this.text, this.function})
      : super(key: key);

  @override
  State<InputPasswordField> createState() => _InputPasswordFieldState();
}

class _InputPasswordFieldState extends State<InputPasswordField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
      child: TextFormField(
        controller: widget.textEditingController,
        textInputAction: TextInputAction.done,
        validator: (value) {
          return widget.function!(value!);
        },
        obscureText: !_passwordVisible,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
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
          hintStyle: TextStyle(fontWeight: FontWeight.bold),
          hintText: widget.text,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          prefixIcon: Icon(
            Icons.key,
            color: primaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off),
            color: primaryColor,
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
      ),
    );
  }
}
