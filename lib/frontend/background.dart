import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class background_page extends StatelessWidget {
  final Widget child;
  const background_page({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'images/top1.png',
              width: MediaQuery.of(context).size.width,
            ),
          )
        ],
      ),
    );
  }
}
