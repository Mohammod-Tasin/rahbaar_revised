import 'package:flutter/material.dart';
class Currentstudentpage extends StatelessWidget {
  const Currentstudentpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Students"),
        centerTitle: true,
      ),
      body: Center(
        child:
        Text(
          "Current Student Page"
        ),
      ),
    );
  }
}
