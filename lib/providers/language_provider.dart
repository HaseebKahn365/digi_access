import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  bool isUrdu = false;
  bool isSpeakerOn = true;
  final AudioPlayer _audioPlayer = AudioPlayer();

  void toggleLanguage() {
    isUrdu = !isUrdu;
    log('Language toggled: $isUrdu');
    //play the login audio again
    playAudio('_/login.mp3');
    notifyListeners();
  }

  void setSpeaker(bool value) {
    isSpeakerOn = value;
    notifyListeners();
  }

  Future<void> playAudio(String audioAsset) async {
    if (!isSpeakerOn) {
      log('Speaker is off, not playing audio');
      return;
    }
    log('Playing Audio asset: $audioAsset');
    try {
      //split '_/main.mp3');
      //replace _ with audioUrdu or audioPashto
      String properPath = audioAsset.replaceAll(
        '_',
        isUrdu ? 'audioUrdu' : 'audioPashto',
      );
      await _audioPlayer.play(AssetSource(properPath));
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  //stop and dispose the audio player
  Future<void> stopAndDisposeAudio() async {
    log('Stopping and disposing audio player');
    await _audioPlayer.stop();
    log('Audio stopped');
    await _audioPlayer.dispose();
  }

  @override
  void dispose() {
    stopAndDisposeAudio();
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
