import 'package:digi_access/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EduSubScreen extends StatefulWidget {
  final String videoUrl;
  const EduSubScreen({super.key, required this.videoUrl});

  @override
  State<EduSubScreen> createState() => _EduSubScreenState();
}

class _EduSubScreenState extends State<EduSubScreen> {
  late YoutubePlayerController _controller;
  bool _isPlaying = false;
  @override
  void initState() {
    super.initState();
    final languageProvider = Provider.of<LanguageProvider>(
      context,
      listen: false,
    );
    languageProvider.stopAndDisposeAudio();

    // Enable all orientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: const Color(0xFF2F2F4F),
      body: SafeArea(
        child:
            isLandscape
                ? Center(
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.deepPurple,
                  ),
                )
                : SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 120, // Increased width
                                height: 120, // Increased height
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(
                                    16,
                                  ), // Larger radius
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 60,
                                  ), // Larger icon
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                              Container(
                                width: 120, // Increased width
                                height: 120, // Increased height
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(
                                    16,
                                  ), // Larger radius
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.home,
                                    color: Colors.white,
                                    size: 60,
                                  ), // Larger icon
                                  onPressed: () {
                                    Navigator.of(
                                      context,
                                    ).popUntil((route) => route.isFirst);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.deepPurple,
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 32.0),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Colors.deepPurple,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(
                                _isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 40,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPlaying = !_isPlaying;
                                  _isPlaying
                                      ? _controller.play()
                                      : _controller.pause();
                                });
                              },
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
