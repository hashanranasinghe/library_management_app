import 'package:flutter/material.dart';
import 'package:library_management_app/api/constant.dart';

class DetailsDialog {
  static builtDetailsDialog(context, imageUrl, userName, bookName, bDate, rDate,
          lateDays, money) =>
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => Dialog(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  height: 500.0,
                  width: 300.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Video Name: ${userName}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          )),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Book Name: ${bookName}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Book User: $userName',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Date: $bDate',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          ' Return Date: $rDate',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                      lateDays != null && money != null
                          ? Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    'Late days: $lateDays',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    'Money: $money',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                ),
                                _buildCancel(context)
                              ],
                            )
                          : _buildCancel(context)
                    ],
                  ),
                ),
              ));

  static Widget _buildCancel(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 50,
          ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFEFEFEF),
                    fontSize: 20),
              )),
        ],
      ),
    );
  }
}
