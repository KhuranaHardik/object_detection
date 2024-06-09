import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:object_detection/screens/camera.dart';
import 'package:object_detection/utils/global.dart';
import 'package:tensorflow_lite_flutter/tensorflow_lite_flutter.dart';

import 'dart:math' as math;

import 'bounding_box.dart';

const String ssd = "SSDMobileNet";

class ObjectScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const ObjectScreen(this.cameras, {super.key});

  @override
  State<ObjectScreen> createState() => _ObjectScreenState();
}

class _ObjectScreenState extends State<ObjectScreen> {
  List<dynamic> _recognitions = [];
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  loadModel() async {
    String? result;

    switch (_model) {
      case ssd:
        result = await Tflite.loadModel(
          labels: "assets/ssd_mobilenet.txt",
          model: "assets/ssd_mobilenet.tflite",
        );
    }
    printDebug(result.toString());
  }

  onSelectModel(model) {
    setState(() {
      _model = model;
    });

    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onSelectModel(ssd);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Object Detection",
          style: TextStyle(
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
      ),
      body: _model == ""
          ? Container()
          : Stack(
              children: [
                Camera(widget.cameras, _model, setRecognitions),
                BoundingBox(
                  isNullOrEmpty(_recognitions) ? [] : _recognitions,
                  math.max(_imageHeight, _imageWidth),
                  math.min(_imageHeight, _imageWidth),
                  screen.width,
                  screen.height,
                  _model,
                )
              ],
            ),
    );
  }
}
