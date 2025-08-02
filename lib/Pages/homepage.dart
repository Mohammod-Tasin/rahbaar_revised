import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahbar_revised/Pages/allAlumniPage.dart';
import 'package:rahbar_revised/Pages/currentStudentPage.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _searchFocusNode.addListener((){
      setState(() {
        _isSearchFocused=_searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(Icons.beach_access_rounded), Text("Rahbaar")],
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text("L O G O", style: TextStyle(fontSize: 35)),
                ),
              ),

              ListTile(
                leading: Icon(Icons.home),
                title: Text("Alumni Page", style: TextStyle(fontSize: 20)),
                onTap: () {
                  // First, close the drawer
                  Navigator.pop(context);
                  // Then, navigate to the CurrentStudentPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Allalumnipage()),
                  );
                },
//navigator of this current context. push the command that will take us to a different page
              ),

              ListTile(
                leading: Icon(Icons.cabin),
                title: Text("Current Students", style: TextStyle(fontSize: 20)),
                onTap: () {
                  // First, close the drawer
                  Navigator.pop(context);
                  // Then, navigate to the CurrentStudentPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Currentstudentpage()),
                  );
                },

              )
            ],
          ),
        ),
      ),
      body:
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 12.0, 12.0),
                child: SearchBar(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      hintText: "Search alumni, students ...",
                      leading: const Icon(Icons.search),
                  elevation: WidgetStateProperty.all(13),
                  backgroundColor: MaterialStateProperty.all(
                    _isSearchFocused? Colors.white:Colors.white60,
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                  ),
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 16)
                  ),// padding inside the search bar
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                child: Column(
                  children: [
                    Row(
                      children: [

                      ],
                    ),
                  ],
                ),
              )
            ],
          )


    );
  }
}
