import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:object_detection/screens/object_detection.dart';
import 'package:object_detection/utils/global.dart';

List<CameraDescription>? cameras;
void main() async {
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    printDebug('Error $e.code \n Error Message : $e.message');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Object Detection',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ObjectScreen(cameras ?? []),
    );
  }
}
