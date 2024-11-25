import 'package:app_deia/controller/ct_options.dart';
import 'package:app_deia/screens/pg_audio.dart';
import 'package:app_deia/screens/pg_camera.dart';
import 'package:app_deia/screens/pg_config.dart';
import 'package:app_deia/screens/pg_select.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'package:camera/camera.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  
  runApp(MainApp(firstCamera));
}

class MainApp extends StatelessWidget{

  final CameraDescription camera;
  const MainApp(this.camera, {super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme appColorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromRGBO(65, 105, 225, 1),
    ).copyWith(background: const Color.fromRGBO(227, 227, 227, 1));

    return ChangeNotifierProvider(
      create: (context) => OptionsController(),
      child: MaterialApp(
        theme: ThemeData(
            colorScheme: appColorScheme,
              textTheme: GoogleFonts.latoTextTheme(),
              appBarTheme: Theme.of(context).appBarTheme.copyWith(
                    backgroundColor: appColorScheme.primary,
                    foregroundColor: appColorScheme.onPrimary,
                  ),
              expansionTileTheme: Theme.of(context).expansionTileTheme.copyWith(
                    backgroundColor: appColorScheme.surface,
                    collapsedBackgroundColor: appColorScheme.surface,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    collapsedShape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
              listTileTheme: Theme.of(context).listTileTheme.copyWith(
                    tileColor: appColorScheme.surface,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
              inputDecorationTheme:
                  Theme.of(context).inputDecorationTheme.copyWith(
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: appColorScheme.surface,
                      ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      backgroundColor: appColorScheme.primary,
                      foregroundColor: appColorScheme.onPrimary)),
              bottomNavigationBarTheme: Theme.of(context)
                  .bottomNavigationBarTheme
                  .copyWith(backgroundColor: appColorScheme.surface),
              badgeTheme: Theme.of(context).badgeTheme.copyWith(
                    backgroundColor: appColorScheme.onPrimary,
                    textColor: appColorScheme.onBackground,
                  )),
        routes: {
          '/upload': (context) => const PageSelect(),
          '/photograph': (context) => TakePictureScreen(camera: camera),
          '/audio': (context) => const PageAudio(),
          '/config': (context) => const PageConfig(),
        },
        initialRoute: '/upload',
      ),
    );
  }
  
}