import 'package:ca6/res/styles.dart';
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key, required String this.pageTitle}) : super
      (key: key);
  final String pageTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image.asset(
        //   'assets/logo.png',
        //   height: 30,
        // ),
        // SizedBox(width:8),
        Text(
          pageTitle,
          style: CustomStyle.appBarTitle,
          ),
      ],
    );
  }
}
