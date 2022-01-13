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
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Container(
            width: double.infinity,
            height: size.height,
            child: Stack(alignment: Alignment.center, children: <Widget>[
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  'images/top1.png',
                  width: size.width,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  'images/top2.png',
                  width: size.width,
                ),
              ),
              Positioned(
                top: 22,
                right: 15,
                child: Image.asset(
                  'images/logo1.webp',
                  width: size.width * 0.35,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  'images/bottom1.png',
                  width: size.width,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  'images/bottom2.png',
                  width: size.width,
                ),
              ),
              child
            ])));
  }
}
