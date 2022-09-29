import 'dart:ui';

class Dimensions {
  static double pixelRatio = window.devicePixelRatio;
  static double screenHeight = window.physicalSize.height / pixelRatio;
  static double screenWidth = window.physicalSize.width / pixelRatio;

  static double ten = screenHeight / 83.49;
}
