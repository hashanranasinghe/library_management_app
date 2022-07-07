import 'package:flutter/material.dart';
import 'package:library_management_app/api/constant.dart';

class TopScreenWidget extends StatelessWidget {
  const TopScreenWidget(
      {Key? key,
      required GlobalKey<ScaffoldState> scaffoldKey,
      required this.topLeft})
      : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  final Widget topLeft;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: primaryColor,
                ),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                iconSize: 30,
              ),
            ),
            topLeft,
            // IconButton(onPressed: () {}, icon: Icon(Icons.home))
          ],
        ),
      ],
    );
  }
}
