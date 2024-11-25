import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';

class PageAudio extends StatefulWidget {
  const PageAudio({super.key});

  @override
  State<PageAudio> createState() => PageAudioState();
}

class PageAudioState extends State<PageAudio> {
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setAudioSource(
              AudioSource.file('${Directory.systemTemp.path}/tmpaudio'));
    player.play();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    File file = File(arguments['filepath']);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sua transcrição"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: GestureDetector(
        onTap: () {
          player.setAudioSource(
              AudioSource.file('${Directory.systemTemp.path}/tmpaudio'));
          player.play();
        },
        child: Center(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: SizedBox(
              width: 400,
              height: 400,
              child: Image.file(
                file,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popUntil(
              context, (route) => route.settings.name == '/upload');
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}
