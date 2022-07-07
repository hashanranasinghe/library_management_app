import 'package:flutter/material.dart';
import 'package:library_management_app/api/constant.dart';

class ListTileField extends StatelessWidget {
  final IconData icon;
  final String? text;
  final Function function;

  const ListTileField(
      {Key? key,
      required this.icon,
      required this.text,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            function();
          },
          leading: Icon(icon, color: primaryColor),
          textColor: primaryColor,
          title: Text(
            text!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
