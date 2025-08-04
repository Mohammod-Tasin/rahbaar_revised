// lib/Pages/alumni_detail_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Alumnidetailspage extends StatelessWidget {
  final Map<String, dynamic> alumnus;

  const Alumnidetailspage({super.key, required this.alumnus});

  // তথ্যের প্রতিটি সারি (row) তৈরির জন্য helper widget
  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(value, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===== Career সেকশনের ডিজাইনটি এখানে পরিবর্তন করা হয়েছে =====
  Widget _buildCareerTile(Map<String, dynamic> job, {required bool isLast}) {
    final bool isPresent = job['is_present'] ?? false;
    return IntrinsicHeight( // দুটি কলামের উচ্চতা সমান রাখার জন্য
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // বাম দিকের আইকন ও লাইন
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // টাইমলাইনের ডট
              isPresent
                  ? Icon(Icons.check_circle, color: Colors.green, size: 20)
              : Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
              ),
              // শেষ আইটেম না হলে নিচে ভার্টিকাল লাইন আঁকা হবে
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.teal.withOpacity(0.5),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          // ডান দিকের টেক্সট
          Expanded(
            child: Padding(
              // প্রতিটি আইটেমের নিচে একটু ফাঁকা জায়গা
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job['position'] ?? 'N/A',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    job['company'] ?? 'N/A',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // ডেটাবেজ থেকে তথ্যগুলো বের করে আনা হচ্ছে
    final name = alumnus['name'] ?? 'N/A';
    final series = alumnus['Series']?.toString() ?? 'N/A';
    final department = alumnus['Department'] ?? 'N/A';
    final email = alumnus['email'] ?? 'N/A';
    final phone = alumnus['Phone No.'] ?? 'N/A';
    final alternativePhone = alumnus['Alternative Phone No.'] ?? 'Not Available';
    final presentAddress= alumnus['Present Address in Detail'] ?? 'Not Available';
    // final currentJob= alumnus['Current Job in Detail'] ?? 'N/A';
    // final prevJob= alumnus['Current Job in Detail']?? 'N/A';
    final college = alumnus['College'] ?? 'N/A';
    final daysInTableegh = alumnus['Days in Tableegh'] ?? 'N/A';
    final homeDistrict= alumnus['Home District'] ?? 'N/A';
    final bloodGroup= alumnus['Blood Group'] ?? 'N/A';
    final List<dynamic> careerHistory = alumnus['career_history'] ?? [];

    careerHistory.sort((a, b) {
      bool isAPresent = a['is_present'] ?? false;
      bool isBPresent = b['is_present'] ?? false;
      if (isAPresent) return -1;
      if (isBPresent) return 1;
      int serialA = a['serial'] ?? 999;
      int serialB = b['serial'] ?? 999;
      return serialA.compareTo(serialB);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      backgroundColor: Colors.white, // الخلفية রঙ সাদা করা হয়েছে
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // ===== উপরের প্রোফাইল সেকশন =====
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.teal,
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : 'A',
                  style: const TextStyle(fontSize: 36, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                name.toUpperCase(),
                style: GoogleFonts.ubuntu(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Series: $series | Department: $department",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 24),

              // ===== বিস্তারিত তথ্যের কার্ড =====
              Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildInfoRow(icon: Icons.email_outlined, title: "Email", value: email),
                      const Divider(),
                      _buildInfoRow(icon: Icons.phone_outlined, title: "Phone", value: phone),
                      const Divider(),
                      _buildInfoRow(icon: Icons.phone_android_outlined, title: "Alternative Phone", value: alternativePhone),
                      const Divider(),
                      _buildInfoRow(icon: Icons.location_on_outlined, title: "Present Address", value: presentAddress),
                      const Divider(),
                      _buildInfoRow(icon: Icons.school_rounded, title: "College", value: college),
                      const Divider(),
                      _buildInfoRow(icon: Icons.shield_moon_rounded, title: "Days in Tableegh", value: daysInTableegh),
                      const Divider(),
                      _buildInfoRow(icon: Icons.home_rounded, title: "Home District", value: homeDistrict),
                      const Divider(),
                      _buildInfoRow(icon: Icons.bloodtype, title: "Blood Group", value: bloodGroup)
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ===== Career সেকশন (যদি career history থাকে) =====
              if (careerHistory.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.work_history_outlined, color: Colors.teal),
                        SizedBox(width: 8),
                        Text(
                          'Career History',
                          style: GoogleFonts.ubuntu(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // টাইমলাইনটি এখানে কার্ড ছাড়া দেখানো হচ্ছে
                    ListView.builder(
                      padding: const EdgeInsets.only(left: 4), // বামে সামান্য জায়গা
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: careerHistory.length,
                      itemBuilder: (context, index) {
                        final job = careerHistory[index] as Map<String, dynamic>;
                        final bool isLast = index == careerHistory.length - 1;
                        return _buildCareerTile(job, isLast: isLast);
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}