import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  bool isUrdu = false;
  bool isSpeakerOn = true;
  final AudioPlayer _audioPlayer = AudioPlayer();

  void toggleLanguage() {
    isUrdu = !isUrdu;
    notifyListeners();
  }

  void setSpeaker(bool value) {
    isSpeakerOn = value;
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

  String getNextButtonText() {
    return isUrdu ? LanguageStrings.nextUrdu : LanguageStrings.nextPashto;
  }
}

class LanguageStrings {
  static const String urduLanguage = 'اردو';
  static const String pashtoLanguage = 'پشتو';

  static const String nextUrdu = 'آگے';
  static const String nextPashto = 'مخکې';
}
