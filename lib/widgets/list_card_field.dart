import 'package:flutter/material.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:string_extensions/string_extensions.dart';

class ListCardField extends StatelessWidget {
  final String? textName;
  final String? imageUrl;
  final String? late;
  final Function? deleteFunction;
  final Function? detailsFunction;
  final Function? updateFunction;

  const ListCardField(
      {Key? key,
      this.textName,
      this.imageUrl,
      this.deleteFunction,
      this.detailsFunction,
      this.late,
      this.updateFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Card(
        color: late != "Late" ? const Color(0xFF2C3333) : Colors.red,
        elevation: 5,
        shadowColor: Color(0xFF395B64),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                  child: Image.network(
                    imageUrl.toString(),
                    height: 100,
                    fit: BoxFit.fill,
                    

                  ),
                ),
                Text(
                  textName.capitalize!.trim().toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE7F6F2),
                      fontSize: 20),
                ),
                Row(
                  children: [
                    detailsFunction != null
                        ? IconButton(
                            onPressed: () {
                              detailsFunction!();
                            },
                            icon: const Icon(
                              Icons.details_rounded,
                              color: Colors.white,
                            ))
                        : Container(
                            width: 1,
                          ),
                    deleteFunction != null
                        ? IconButton(
                            onPressed: () {
                              deleteFunction!();
                            },
                            icon: const Icon(
                              Icons.delete_rounded,
                              color: Colors.white,
                            ),
                          )
                        : Container(
                            width: 1,
                          ),
                    updateFunction != null
                        ? IconButton(
                        onPressed: () {
                          updateFunction!();
                        },
                        icon: const Icon(
                          Icons.update,
                          color: Colors.white,
                        ))
                        : Container(
                      width: 1,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
