import 'package:digi_access/providers/language_provider.dart';
import 'package:digi_access/providers/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSettingsScreenPageView extends StatefulWidget {
  const LanguageSettingsScreenPageView({super.key});

  @override
  _LanguageSettingsScreenPageViewState createState() =>
      _LanguageSettingsScreenPageViewState();
}

class _LanguageSettingsScreenPageViewState
    extends State<LanguageSettingsScreenPageView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    //play
    super.initState();
  }

  void _nextPage() {
    if (_currentPage < 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildNextButton() {
    return Consumer<LanguageProvider>(
      builder:
          (context, languageProvider, child) => Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: _nextPage,
                child: Text(
                  languageProvider.getNextButtonText(),
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            children: [LanguageSelectionPage(), SpeakerControlPage()],
          ),
          if (_currentPage < 1) _buildNextButton(),
        ],
      ),
    );
  }
}

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder:
          (context, languageProvider, child) => Container(
            color: Color(0xFF2C2C54),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.hearing, size: 80, color: Colors.white),
                  SizedBox(height: 20),
                  SizedBox(height: 30),
                  Row(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "اردو",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      Transform.scale(
                        scaleX: -1,
                        child: Switch(
                          value: languageProvider.isUrdu,
                          onChanged: (bool value) {
                            languageProvider.toggleLanguage();
                          },
                        ),
                      ),
                      Text(
                        "پشتو",
                        style: TextStyle(color: Colors.white, fontSize: 30),
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

class SpeakerControlPage extends StatelessWidget {
  const SpeakerControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder:
          (context, languageProvider, child) => Container(
            color: Color(0xFF2C2C54),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      languageProvider.setSpeaker(true);
                      //Navigate to main Screen using material routing with pushreplacement
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              languageProvider.isSpeakerOn
                                  ? Colors.green
                                  : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        color:
                            languageProvider.isSpeakerOn
                                ? Colors.green.withOpacity(0.2)
                                : Colors.transparent,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.hearing,
                            size: 60,
                            color:
                                languageProvider.isSpeakerOn
                                    ? Colors.green
                                    : Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                  GestureDetector(
                    onTap: () => languageProvider.setSpeaker(false),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              !languageProvider.isSpeakerOn
                                  ? Colors.red
                                  : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        color:
                            !languageProvider.isSpeakerOn
                                ? Colors.red.withOpacity(0.2)
                                : Colors.transparent,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.hearing_disabled,
                            size: 60,
                            color:
                                !languageProvider.isSpeakerOn
                                    ? Colors.red
                                    : Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
