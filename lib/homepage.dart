import 'package:flutter/material.dart';

class home1 extends StatefulWidget {
  const home1({Key? key}) : super(key: key);

  @override
  State<home1> createState() => _home1State();
}

class _home1State extends State<home1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(color: Colors.yellow),
      ),
          )),
    );
  }
}
