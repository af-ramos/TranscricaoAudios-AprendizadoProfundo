import 'dart:async';
import 'dart:io';

import 'package:app_deia/apis/api_transcribe.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(title: const Text('Tire sua foto')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: CameraPreview(_controller))),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      persistentFooterButtons: [
        IconButton.filled(
            iconSize: 32,
            onPressed: () async {
              try {
                await _initializeControllerFuture;
                final image = await _controller.takePicture();
                if (!context.mounted) return;
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DisplayPictureScreen(
                      imagePath: image.path,
                    ),
                  ),
                );
              } catch (e) {
                throw Exception(e);
              }
            },
            icon: const Icon(Icons.flash_on)),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            if (!context.mounted) return;
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            throw Exception(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    File file = File(imagePath);

    return Scaffold(
      appBar: AppBar(title: const Text('Sua foto')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: Image.file(file))),
      ),
      persistentFooterButtons: [
        IconButton.filled(
            iconSize: 32,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete)),
        IconButton.filled(
            iconSize: 32,
            onPressed: () {
              ApiTranscribe.uploadPhoto(file);
              Navigator.pushNamed(context, '/audio',
                  arguments: {'filepath': imagePath});
            },
            icon: const Icon(Icons.check))
      ],
    );
  }
}
