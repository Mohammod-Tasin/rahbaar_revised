import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahbar_revised/Data/card_data.dart';
import 'package:rahbar_revised/Pages/allAlumniPage.dart';
import 'package:rahbar_revised/Pages/contactWithDeveloperPage.dart';
import 'package:rahbar_revised/Pages/currentStudentPage.dart';

// ===== আপডেট কার্যকারিতার জন্য প্রয়োজনীয় ইম্পোর্ট =====
import 'package:flutter/foundation.dart' show kIsWeb; // Web প্ল্যাটফর্ম চেক করার জন্য
import 'dart:io' show Platform; // Android ও Windows প্ল্যাটফর্ম চেক করার জন্য
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ota_update/ota_update.dart';
import 'package:url_launcher/url_launcher.dart';

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
    // ===== অ্যাপ চালু হওয়ার সময় আপডেট চেক করার জন্য ফাংশন কল =====
    _checkForUpdate();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  // ===== ইন-অ্যাপ আপডেট কার্যকারিতার জন্য ফাংশনগুলো =====

  Future<void> _checkForUpdate() async {
    if (kIsWeb) return;

    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;

      // ===== পরিবর্তন ১: GitHub URL টি এখানে ঠিক করা হয়েছে =====
      final url = Uri.parse(
          'https://raw.githubusercontent.com/Mohammod-Tasin/rahbaar_revised/main/update.json');

      print('Checking for updates from: $url'); // <-- ডিবাগ করার জন্য যোগ করা হয়েছে

      final response = await http.get(url);

      // ===== পরিবর্তন ২: ডিবাগিং এর জন্য Print স্টেটমেন্ট যোগ করা হয়েছে =====
      if (response.statusCode == 200) {
        print('Successfully fetched update.json!');
        print('Response body: ${response.body}');

        final Map<String, dynamic> json = jsonDecode(response.body);

        String platformKey = '';
        if (Platform.isAndroid) platformKey = 'android';
        if (Platform.isWindows) platformKey = 'windows';

        if (platformKey.isNotEmpty && json.containsKey(platformKey)) {
          String latestVersion = json[platformKey]['version'];
          String downloadUrl = json[platformKey]['url'];

          print('Current App Version: $currentVersion');
          print('Latest Version from Server: $latestVersion');

          if (latestVersion.compareTo(currentVersion) > 0) {
            _showUpdateDialog(latestVersion, downloadUrl);
          } else {
            _showUpToDateSnackbar();
          }
        }
      } else {
        print('Failed to fetch update.json. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred while checking for updates: $e');
    }
  }

  // ===== নতুন SnackBar দেখানোর ফাংশন =====
  void _showUpToDateSnackbar() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('You are using the latest version.'),
            backgroundColor: Colors.green[600],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(10),
          ),
        );
      }
    });
  }

  void _showUpdateDialog(String version, String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isAndroid = Platform.isAndroid;
        String buttonText = isAndroid ? "Update Now" : "Download";

        return AlertDialog(
          title: const Text("New Update Available!"),
          content: Text("A new version (v$version) is available. Would you like to get it?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Later"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(buttonText),
              onPressed: () {
                Navigator.of(context).pop();
                if (isAndroid) {
                  _startAndroidUpdate(url);
                } else {
                  _launchDownloadUrl(url);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _startAndroidUpdate(String url) async {
    try {
      OtaUpdate().execute(url).listen(
        (OtaEvent event) {
          print('EVENT: ${event.status} : ${event.value}');
        },
      );
    } catch (e) {
      print('Failed to start OTA update: $e');
    }
  }

  void _launchDownloadUrl(String url) async {
    final Uri downloadUri = Uri.parse(url);
    if (await canLaunchUrl(downloadUri)) {
      await launchUrl(downloadUri, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $url');
    }
  }

  // একটি helper widget যা প্রতিটি কার্ড তৈরি করবে (অপরিবর্তিত)
  Widget _buildClickableCard(CardItem item) {
    return Card(
      elevation: 4,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
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
          } else if (item.title == "Contact with developer") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Contactwithdeveloperpage()),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(item.icon, size: 40, color: item.color),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item.subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // আপনার build মেথডটি সম্পূর্ণ অপরিবর্তিত
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
              title: Text("Alumni", style: GoogleFonts.ubuntu(fontSize: 25)),
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
              title: Text("Current Students", style: GoogleFonts.ubuntu(
                fontSize: 25,
              )),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Currentstudentpage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.people_rounded),
              title: Text("Queries or Suggestions", style: GoogleFonts.ubuntu(
                fontSize: 25,
              )),
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth >= 600;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 12.0),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: SearchBar(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      hintText: "Search alumni, students ...",
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
              Expanded(
                child: isDesktop
                    ? SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 20.0,
                            runSpacing: 20.0,
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
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        itemCount: cardItems.length,
                        itemBuilder: (context, index) {
                          final item = cardItems[index];
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