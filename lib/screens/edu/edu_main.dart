import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//here is the main screen for education

/*
Page description:
create the following cards:
1. Recognize Money
2. Take Quiz
3. Shopping Practice


 */
class EduMainScreen extends StatelessWidget {
  const EduMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2F4F),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(height: 20),
            // Cards
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: [
                    _buildCard(context, 'Recognize Money'),
                    const SizedBox(height: 16),
                    _buildCard(context, 'Take Quiz'),
                    const SizedBox(height: 16),
                    _buildCard(context, 'Shopping Practice'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title) {
    void navigateToScreen() {
      // Placeholder for navigation logic
      print('Navigating to $title');

      switch (title) {
        case 'Recognize Money':
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RecognizeMoneyScreen(),
            ),
          );
          break;
        case 'Take Quiz':
          // Navigate to quiz screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LearnCurrencyScreen(),
            ),
          );
          break;
        case 'Shopping Practice':
          // Navigate to shopping practice screen
          break;
      }
    }

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        navigateToScreen();
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/edu/notes.png',
                height: 100,
                width: 100,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
Design a Flutter app screen to help users recognize Pakistani currency notes (PKR 50, 100, 500, 1000, 5000) using images and voice guidance. Include:

Visual Display: Show clear images of each note.

Voice Assistance: Play voice descriptions when a note is tapped (e.g., 'This is a 500 Rupee note...').

Simple UI: Use Pakistan’s colors (green/white) and intuitive icons.

Focus on accessibility—no camera or complex ML required. Just tap an image to hear details!"*

Example Interaction:

User taps PKR 1000 image → App says: *"1000 Rupee note. Color: Green. Features: Quaid-e-Azam portrait.
 */

class RecognizeMoneyScreen extends StatelessWidget {
  const RecognizeMoneyScreen({super.key});

  void _playVoiceDescription(String description) {
    // Placeholder for playing voice description
    print(description); // Replace with actual audio playback logic
  }

  @override
  Widget build(BuildContext context) {
    final notes = [
      {
        'value': '50',
        'color': 'Purple',
        'image': 'https://www.sbp.org.pk/banknotes/50/images/front.JPG',
      },
      {
        'value': '100',
        'color': 'Green',
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf3PsRmCqILGGfs6Eps4xN-3HVKyMWgRNYgg&s',
      },
      {
        'value': '500',
        'color': 'Brown',
        'image': 'https://www.sbp.org.pk/finance/images/500new/500ovifront.jpg',
      },
      {
        'value': '1000',
        'color': 'Blue',
        'image': 'https://www.sbp.org.pk/finance/images/1000/big.JPG',
      },
      {
        'value': '5000',
        'color': 'Orange',
        'image': 'https://www.sbp.org.pk/images/notes/front-5000.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recognize Money'),
        backgroundColor: const Color(0xFF01411C), // Green color
      ),
      backgroundColor: Colors.white,
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return GestureDetector(
            onTap: () {
              final description =
                  '${note['value']} Rupee note. Color: ${note['color']}. Features: Quaid-e-Azam portrait.';
              _playVoiceDescription(description);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFF01411C), width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: note['image']!,
                    height: 250,
                    width: 250,
                    fit: BoxFit.contain,
                    placeholder:
                        (context, url) => const CircularProgressIndicator(),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'PKR ${note['value']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Design a Flutter screen using PageView to create a currency quiz for Pakistani notes (PKR 50, 100, 500, 1000, 5000):

// Random Note Announcement: Voice says "Find the 500 Rupee note!" (randomly selected).

// Interactive PageView: Swipeable gallery of all note images.

// User Selection: Tap the correct note → "Correct!" (voice + green checkmark). Wrong tap → "Try again!" (voice + red X).

// Visual Feedback: Highlight the correct note after each attempt.

// Accessibility: Voice instructions + large tap targets.
class LearnCurrencyScreen extends StatefulWidget {
  const LearnCurrencyScreen({super.key});

  @override
  _LearnCurrencyScreenState createState() => _LearnCurrencyScreenState();
}

class _LearnCurrencyScreenState extends State<LearnCurrencyScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, String>> notes = [
    {
      'value': '50',
      'image': 'https://www.sbp.org.pk/banknotes/50/images/front.JPG',
    },
    {
      'value': '100',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf3PsRmCqILGGfs6Eps4xN-3HVKyMWgRNYgg&s',
    },
    {
      'value': '500',
      'image': 'https://www.sbp.org.pk/finance/images/500new/500ovifront.jpg',
    },
    {
      'value': '1000',
      'image': 'https://www.sbp.org.pk/finance/images/1000/big.JPG',
    },
    {
      'value': '5000',
      'image': 'https://www.sbp.org.pk/images/notes/front-5000.jpg',
    },
  ];

  late String targetNote;
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;
  bool isAnswered = false;
  String? selectedNote;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _generateNewTarget();
  }

  void _generateNewTarget() {
    final random = Random();
    targetNote = notes[random.nextInt(notes.length)]['value']!;
    _announceTarget();
  }

  void _announceTarget() {
    // Placeholder for voice announcement
    print('Tap the $targetNote Rupee note!');
  }

  void _checkAnswer(String selectedNote) {
    setState(() {
      isAnswered = true;
      this.selectedNote = selectedNote;
    });

    // Placeholder for feedback
    if (selectedNote == targetNote) {
      print('Correct!');
    } else {
      print('Try again!');
    }

    Future.delayed(const Duration(seconds: 2), () {
      if (selectedNote == targetNote) {
        setState(() {
          isAnswered = false;
          this.selectedNote = null;
          _generateNewTarget();
        });
      } else {
        setState(() {
          isAnswered = false;
          this.selectedNote = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Currency'),
        backgroundColor: const Color(0xFF01411C), // Green color
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Tap the $targetNote Rupee note!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                      notes.map((note) {
                        final isCorrect = note['value'] == targetNote;
                        final isSelected = note['value'] == selectedNote;
                        return GestureDetector(
                          onTap: () {
                            if (!isAnswered) {
                              _checkAnswer(note['value']!);
                            }
                          },
                          child: AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale:
                                    isCorrect && isSelected
                                        ? _pulseAnimation.value
                                        : 1.0,
                                child: child,
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(
                                24.0,
                              ), // Added padding
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color:
                                      isAnswered && isCorrect && isSelected
                                          ? Colors.green
                                          : isAnswered && isSelected
                                          ? Colors.red
                                          : const Color(0xFF01411C),
                                  width: 3,
                                ),
                                boxShadow:
                                    isCorrect && isSelected
                                        ? [
                                          BoxShadow(
                                            color: Colors.green.withOpacity(
                                              0.5,
                                            ),
                                            blurRadius: 10,
                                            spreadRadius: 5,
                                          ),
                                        ]
                                        : [],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: note['image']!,
                                    height: 250,
                                    width: 250,
                                    fit: BoxFit.contain,
                                    placeholder:
                                        (context, url) =>
                                            const CircularProgressIndicator(),
                                    errorWidget:
                                        (context, url, error) =>
                                            const Icon(Icons.error),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'PKR ${note['value']}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
