import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  bool _isUrdu = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool get isUrdu => _isUrdu;
  AudioPlayer get audioPlayer => _audioPlayer;

  void toggleLanguage() {
    _isUrdu = !_isUrdu;
    notifyListeners();
  }

  Future<void> playAudio(String audioAsset) async {
    try {
      await _audioPlayer.play(AssetSource(audioAsset));
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
