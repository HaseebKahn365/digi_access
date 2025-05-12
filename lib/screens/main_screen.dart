//here is the main screen with 4 domains:

import 'package:digi_access/providers/language_provider.dart';
import 'package:digi_access/screens/edu/edu_main.dart';
import 'package:digi_access/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: GridUIScreen());
  }
}

class GridUIScreen extends StatefulWidget {
  const GridUIScreen({super.key});

  @override
  State<GridUIScreen> createState() => _GridUIScreenState();
}

class _GridUIScreenState extends State<GridUIScreen> {
  @override
  void initState() {
    super.initState();
    //play audio on page load
    final languageProvider = Provider.of<LanguageProvider>(
      context,
      listen: false,
    );
    languageProvider.playAudio('_/main.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2C54),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.logout, color: Colors.white, size: 80),
                  onPressed: () {
                    // Navigate to the main screen
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LanguageSettingsScreenPageView(),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    buildImageCard('assets/images/edu.jpg', context),
                    buildImageCard('assets/images/ecom.jpg', context),
                    buildImageCard('assets/images/health.jpg', context),
                    buildImageCard('assets/images/agri.png', context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImageCard(String imagePath, context) {
    void navigateToPage() {
      // Implement navigation logic here
      // For example, you can use Navigator.push to navigate to a new screen

      switch (imagePath) {
        case 'assets/images/edu.jpg':
          // Navigate to Education screen
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => EduMainScreen()));
          break;
        case 'assets/images/ecom.jpg':
          // Navigate to E-commerce screen
          break;
        case 'assets/images/health.jpg':
          // Navigate to Health screen
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(builder: (context) => HealthScreen()),
          // );
          break;
        case 'assets/images/agri.png':
          // Navigate to Agriculture screen
          break;
      }
    }

    return GestureDetector(
      onTap: navigateToPage,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
