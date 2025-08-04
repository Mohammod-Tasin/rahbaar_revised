import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahbar_revised/Pages/allAlumniPage.dart';
import 'package:rahbar_revised/Pages/currentStudentPage.dart';
import '../Data/card_data.dart';
import 'contactWithDeveloperPage.dart';

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
          children: [Icon(Icons.beach_access_rounded),
            Text(
              "Rahbaar",
              style: GoogleFonts.ubuntu(),
          )],
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
                  child: Text("R A H B A A R", style: TextStyle(fontSize: 35)),
                ),
              ),

              ListTile(
                leading: Icon(Icons.school_rounded),
                title: Row(
                  children: [
                    Text("Alumni", style: GoogleFonts.ubuntu(
                      fontSize: 25,
                    )),
                  ],
                ),
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
                leading: Icon(Icons.people_rounded),
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
              ),

              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 3/2,
                  ),

                  itemCount: cardItems.length,
                  // The itemBuilder function is called for each item in the grid
                  itemBuilder: (context, index) {
                    // HERE IT IS!
                    // 'item' is created to hold one object from the cardItems list.
                    final item = cardItems[index];

                    // Now we use the 'item' to build the Card widget
                    return InkWell(
                      onTap: (){
                        if(item.title== "Alumni page") {
                          Navigator.push(
                            context, MaterialPageRoute(
                              builder: (context) => Allalumnipage()),
                          );
                        }else if(item.title=="Current Student Page"){
                          Navigator.push(
                            context, MaterialPageRoute(
                              builder: (context) => Currentstudentpage()),
                          );
                        }
                        else if(item.title=="Contact with developer"){
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context)=> Contactwithdeveloperpage()));
                        }
                        // আপনি চাইলে অন্যান্য কার্ডের জন্যও একই রকম ভাবে পেজ যোগ করতে পারেন
                      },
                      child: Card(
                        semanticContainer: true,
                        borderOnForeground: true,
                        elevation: 10,
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            print('${item.title} tapped!');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                item.icon, // Using item's data
                                size: 40,
                                color: item.color, // Using item's data
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item.title, // Using item's data
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.subtitle, // Using item's data
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
    );
  }
}