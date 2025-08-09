import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahbar_revised/Pages/alumniDetailsPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Allalumnipage extends StatefulWidget {
  const Allalumnipage({super.key});

  @override
  State<Allalumnipage> createState() => _AllalumnipageState();
}

class _AllalumnipageState extends State<Allalumnipage> {
  // ===== পরিবর্তন ১: ভ্যারিয়েবলটি এখানে শুধু ডিক্লেয়ার করা হয়েছে =====
  late final Future<List<Map<String, dynamic>>> _alumniFuture;

  // ===== পরিবর্তন ২: initState() মেথড যোগ করা হয়েছে =====
  @override
  void initState() {
    super.initState();
    // ডেটা আনার কাজটি এখন initState() এর ভেতরে করা হচ্ছে
    _alumniFuture = Supabase
        .instance
        .client
        .from('Alumni Datas')
        .select('*');
  }

  @override
  Widget build(BuildContext context) {
    // build মেথডের বাকি কোড সম্পূর্ণ অপরিবর্তিত থাকবে
    return Scaffold(
      appBar: AppBar(
        title: Text("Alumni Page", style: GoogleFonts.ubuntu()),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _alumniFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text(
                "Something went wrong! Please try again.",
                style: GoogleFonts.ubuntu(fontSize: 15),
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No alumni found",
                style: GoogleFonts.ubuntu(fontSize: 15),
              ),
            );
          }

          final alumniList = snapshot.data!;

          return ListView.builder(
            itemCount: alumniList.length,
            itemBuilder: (context, index) {
              final alumni = alumniList[index];
              final alumniName = alumni['name'] ?? 'No Name';
              final alumniSeries = alumni['Series']?.toString() ?? 'N/A';
              final alumniDept = alumni['Department'] ?? 'N/A';
              final imageUrl = alumni['profile_image_url'] ?? '';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.white,
                elevation: 5,
                child: ListTile(
                  title: Text(
                    alumniName,
                    style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("$alumniDept'$alumniSeries"),
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    backgroundImage: (imageUrl.isNotEmpty && Uri.parse(imageUrl).isAbsolute)
                        ? NetworkImage(imageUrl)
                        : null,
                    child: (imageUrl.isEmpty || !Uri.parse(imageUrl).isAbsolute)
                        ? Text(
                            alumniName.isNotEmpty ? alumniName[0].toUpperCase() : 'A',
                            style: TextStyle(color: Colors.grey[700]),
                          )
                        : null,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Alumnidetailspage(alumnus: alumni),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}