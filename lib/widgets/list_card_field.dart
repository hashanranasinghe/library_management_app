import 'package:flutter/material.dart';
import 'package:library_management_app/api/constant.dart';

class ListCardField extends StatelessWidget {
  final String? textName;
  final String? imageUrl;
  final String? late;
  final Function? deleteFunction;
  final Function? detailsFunction;

  const ListCardField(
      {Key? key,
      this.textName,
      this.imageUrl,
      this.deleteFunction,
      this.detailsFunction,
      this.late})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Card(
        color: late != "Late" ? primaryColor : Colors.red,
        elevation: 8,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  imageUrl.toString(),
                  width: 50,
                ),
                Text(
                  textName!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                          )
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
