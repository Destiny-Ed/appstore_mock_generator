import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockup_app/enum/enums.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image/image.dart' as img;

abstract interface class ToolsPort {
  void changeBgColor(Color color);
  void changeTextColor(Color color);
  void pickAppImage();
  void insertText(int index, String value);
  void changeDimension(int index, String value);
  void switchPlatform(PlatformType platform);
  void changeLayout(MockUpLayoutType type);
  void captureAndSaveMockup();
}

class ToolsProvider extends ChangeNotifier implements ToolsPort {
  ImagePicker picker = ImagePicker();

  Color bgColor = const Color(0xff443a49);
  Color textColor = const Color(0xffffffff);

  ScreenshotController screenshotController = ScreenshotController();

  PlatformType selectedPlatform = PlatformType.Android;

  MockUpLayoutType selectedMockupLayout = MockUpLayoutType.Phone;

  String selectedImage = '';

  String titleText = '';

  String subtitleText = '';

  bool isBusy = false;

  //dimension
  int? width;
  int? height;

  @override
  void captureAndSaveMockup() async {
    if (height != null && width != null) {
      isBusy = true;
      notifyListeners();
      final capture = await screenshotController.capture();

      ///manipulate the image
      img.Image capturedImage = img.decodeImage(capture!)!;

      img.Image resizedImage = img.copyResize(capturedImage, width: width!, height: height!);

      Uint8List resizedBytes = Uint8List.fromList(img.encodePng(resizedImage));

      await FileSaver.instance.saveFile(name: "destinyed", bytes: resizedBytes, mimeType: MimeType.png);

      isBusy = false;
      notifyListeners();
    } else {
      print("Input height and width");
    }
  }

  @override
  void changeBgColor(Color color) {
    bgColor = color;
    notifyListeners();
  }

  @override
  void changeDimension(int index, String value) {
    switch (index) {
      case 0:
        width = int.parse(value);
        notifyListeners();
        break;
      case 1:
        height = int.parse(value);
        notifyListeners();
        break;
    }
  }

  @override
  void changeLayout(MockUpLayoutType type) {
    selectedMockupLayout = type;
    notifyListeners();
  }

  @override
  void changeTextColor(Color color) {
    textColor = color;
    notifyListeners();
  }

  @override
  void insertText(int index, String value) {
    switch (index) {
      case 0:
        titleText = value;
        notifyListeners();
        break;
      case 1:
        subtitleText = value;
        notifyListeners();
        break;
    }
  }

  @override
  void pickAppImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage = image.path;
      notifyListeners();
    }
  }

  @override
  void switchPlatform(PlatformType platform) {
    selectedPlatform = platform;
    notifyListeners();
  }
}
