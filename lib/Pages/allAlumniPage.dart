import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Allalumnipage extends StatelessWidget {
  const Allalumnipage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alumni Page"),
      ),
      backgroundColor: Colors.white60,
      body: Center(
        child:
        Text(
          "All Alumni Data Page",
          style: GoogleFonts.ubuntu(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
