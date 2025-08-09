import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahbar_revised/Data/card_data.dart';
import 'package:rahbar_revised/Pages/allAlumniPage.dart';
import 'package:rahbar_revised/Pages/contactWithDeveloperPage.dart';
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
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  // একটি helper widget যা প্রতিটি কার্ড তৈরি করবে, কোড পুনরাবৃত্তি এড়ানোর জন্য
  Widget _buildClickableCard(CardItem item) {
    return Card(
      elevation: 4,
      color: Colors.white,
      clipBehavior: Clip.antiAlias, // Ripple effect-কে কার্ডের বর্ডারের ভেতরে রাখে
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          if (item.title == "Alumni page") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Allalumnipage()),
            );
          } else if (item.title == "Current Student Page") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Currentstudentpage()),
            );
          } else if (item.title == "Queries or Suggestions") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Contactwithdeveloperpage()),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, size: 40, color: item.color),
              const SizedBox(height: 12),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                item.subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.hub_outlined),
            const SizedBox(width: 8),
            Text("Rahbaar", style: GoogleFonts.ubuntu()),
          ],
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        width: 350,
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Center(
                child: Text("R A H B A A R", style: TextStyle(fontSize: 35)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.school_rounded),
              title: Text("Alumni", style: GoogleFonts.ubuntu(fontSize: 23)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Allalumnipage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.people_rounded),
              title: Text("Current Students", style: GoogleFonts.ubuntu(fontSize: 23)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Currentstudentpage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.comment_rounded),
              title: Text("Queries or Suggestions", style: GoogleFonts.ubuntu(fontSize: 23)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Contactwithdeveloperpage()),
                );
              },
            ),
          ],
        ),
      ),
      // ===== মূল পরিবর্তনটি এখানে করা হয়েছে =====
      body: LayoutBuilder(
        builder: (context, constraints) {
          // আমরা স্ক্রিনের প্রস্থ (width) চেক করছি
          bool isDesktop = constraints.maxWidth >= 600;

          return Column(
            children: [
              // SearchBar
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 12.0),
                // বড় স্ক্রিনের জন্য সার্চ বারকে মাঝে আনা হয়েছে
                child: Center(
                  child: Container(
                    // বড় স্ক্রিনে সার্চ বারের একটি নির্দিষ্ট সর্বোচ্চ প্রস্থ থাকবে
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: SearchBar(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      hintText: "Searchbar is under construction...",
                      leading: const Icon(Icons.search),
                      elevation: WidgetStateProperty.all(2),
                      shadowColor: WidgetStateProperty.all(Colors.black26),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                ),
              ),

              // কার্ড সেকশন
              Expanded(
                child: isDesktop
                    // --- ট্যাবলেট ও ল্যাপটপ ডিজাইন ---
                    ? SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Wrap(
                            alignment: WrapAlignment.center, // কার্ডগুলোকে মাঝে আনে
                            spacing: 20.0, // কার্ডের মধ্যে পাশাপাশি দূরত্ব
                            runSpacing: 20.0, // কার্ডের মধ্যে ওপর-নিচ দূরত্ব
                            children: cardItems.map((item) {
                              return SizedBox(
                                width: 280,
                                height: 180,
                                child: _buildClickableCard(item),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    // --- মোবাইল ডিজাইন ---
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        itemCount: cardItems.length,
                        itemBuilder: (context, index) {
                          final item = cardItems[index];
                          // প্রতিটি কার্ডের জন্য একটি নির্দিষ্ট উচ্চতা ও নিচের মার্জিন দেওয়া হয়েছে
                          return Container(
                            height: 160,
                            margin: const EdgeInsets.only(bottom: 16.0),
                            child: _buildClickableCard(item),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}