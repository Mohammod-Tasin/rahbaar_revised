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
  final Future<List<Map<String, dynamic>>> _alumniFuture = Supabase
      .instance
      .client
      .from('Alumni Datas')
      .select();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alumni Page", style: GoogleFonts.ubuntu()),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _alumniFuture,
        builder: (context, snapshot) {
          // যদি ডেটা লোড হতে থাকে, একটি লোডিং সিম্বল দেখান
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // যদি কোনো এরর হয়, এরর মেসেজ দেখান
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text(
                "Something went wrong! Please try again.",
                style: GoogleFonts.ubuntu(fontSize: 15),
              ),
            );
          }
          // যদি ডেটা সফলভাবে আসে কিন্তু খালি হয়
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No alumni found",
                style: GoogleFonts.ubuntu(fontSize: 15),
              ),
            );
          }
          // ডেটা সফলভাবে চলে আসলে
          final alumniList = snapshot.data!;
          // ListView.builder দিয়ে প্রতিটি অ্যালামনাইয়ের জন্য একটি Card তৈরি করুন
          return ListView.builder(
            itemCount: alumniList.length,
            itemBuilder: (context, index) {
              final alumni = alumniList[index];
              final alumniName = alumni['name'] ?? 'No Name';
              final alumniSeries =
                  alumni['Series']?.toString() ??
                  'N/A'; // .toString() ব্যবহার করা নিরাপদ
              final alumniDept = alumni['Department'] ?? 'N/A';
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
                    backgroundColor: Colors.black12,
                    child: Text(
                      alumniName.isNotEmpty ? alumniName[0].toUpperCase() : 'A',
                      style: TextStyle(color: Colors.white),
                    ),
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
