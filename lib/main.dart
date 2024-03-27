import 'dart:io';

import 'package:deepar_flutter/deepar_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DeepArController controller = DeepArController();

  final filters = [
    Filters(
        filterPath: 'burning_effect.deepar', imagePath: 'burning_effect.png'),
    Filters(
        filterPath: 'Neon_Devil_Horns.deepar',
        imagePath: 'Neon_Devil_Horns.png'),
    Filters(filterPath: '8bitHearts.deepar', imagePath: '8bitHearts.png'),
    Filters(
        filterPath: 'Elephant_Trunk.deepar', imagePath: 'Elephant_Trunk.png'),
    Filters(filterPath: 'Emotion_Meter.deepar', imagePath: 'Emotion_Meter.png'),
    Filters(
        filterPath: 'Emotions_Exaggerator.deepar',
        imagePath: 'Emotions_Exaggerator.png'),
    Filters(filterPath: 'Fire_Effect.deepar', imagePath: 'Fire_Effect.png'),
    Filters(filterPath: 'flower_face.deepar', imagePath: 'flower_face.png'),
    Filters(
      filterPath: 'galaxy_background.deepar',
      imagePath: 'galaxy_background.png',
    ),
    Filters(filterPath: 'Hope.deepar', imagePath: 'Hope.png'),
    Filters(filterPath: 'Humanoid.deepar', imagePath: 'Humanoid.png'),
    Filters(filterPath: 'MakeupLook.deepar', imagePath: 'MakeupLook.png'),
    Filters(filterPath: 'Snail.deepar', imagePath: 'Snail.png'),
    Filters(
        filterPath: 'Split_View_Look.deepar', imagePath: 'Split_View_Look.jpg'),
    Filters(filterPath: 'Stallone.deepar', imagePath: 'Stallone.png'),
    Filters(filterPath: 'Vendetta_Mask.deepar', imagePath: 'Vendetta_Mask.png'),
    Filters(filterPath: 'viking_helmet.deepar', imagePath: 'viking_helmet.png'),
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<void> initializeController() async {
    await controller.initialize(
      androidLicenseKey:
          '50d983dbef5c353680edf72212e3f4ed97da6e8b3aa7e0dfe86b9a2d97540e8ea8494e87e54efdbc',
      iosLicenseKey: '',
      resolution: Resolution.high,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: initializeController(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  Transform.scale(
                    scale: 1.4,
                    child: DeepArPreview(controller),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: filters.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              controller.switchEffect(File(
                                      'assets/filters/${filters[index].filterPath}')
                                  .path);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/previews/${filters[index].imagePath}'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              );
            } else {
              return const Center(
                child: Text('Please wait...'),
              );
            }
          },
        ),
      ),
    );
  }
}

class Filters {
  String imagePath;
  String filterPath;
  Filters({required this.filterPath, required this.imagePath});
}
