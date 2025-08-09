import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Currentstudentpage extends StatelessWidget {
  const Currentstudentpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Current Students",
        style: GoogleFonts.ubuntu(
        ),
      ), centerTitle: true, backgroundColor: Colors.white,),
      body: Center(child: Text("Page is under construction...",
      style: GoogleFonts.ubuntu(
        fontSize: 25
      ),
      )),
    );
  }
}