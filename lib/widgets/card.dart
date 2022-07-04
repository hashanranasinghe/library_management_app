import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_management_app/api/constant.dart';

class CardView extends StatelessWidget {
  const CardView(
      {Key? key, required this.topic, this.icon, required this.function})
      : super(key: key);

  final String topic;
  final IconData? icon;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
      child: GestureDetector(
        onTap: () {
          function();
        },
        child: Card(
          elevation: 8,
          color: backColor,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 110,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10.0))),
              ),
              Container(
                width: 130,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Icon(
                          icon,
                          color: Colors.black,
                          size: 30,
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        topic,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
