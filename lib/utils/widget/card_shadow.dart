import 'package:flutter/material.dart';
class CardShadow extends StatelessWidget {
  final Widget child;

  final double height, width;
  const CardShadow(
      {Key? key,
      required this.child,
      required this.height,
      required this.width,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        image: const DecorationImage(
            image: AssetImage("assets/bg.png"), fit: BoxFit.cover),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6.0,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(.0),
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            borderRadius:   BorderRadius.all(
              Radius.circular(15),
            ),
           ),
          child: child,
        ),
      ),
    );
  }
}
