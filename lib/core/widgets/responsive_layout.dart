import 'dart:developer';
import 'package:ebtik_tok/core/utils.dart';
import 'package:flutter/material.dart';

enum ScreenSizeCategory {
  small,
  medium,
  tablet,
}

class ResponsiveLayout extends StatelessWidget {
  final Widget small;
  final Widget medium;
  final Widget? tablet;

  const ResponsiveLayout({
    super.key,
    required this.small,
    required this.medium,
    this.tablet,
  });

  @override
  Widget build(BuildContext context) {
    // final screenWidth = getScreenWidth(context);
    // final aspectRatio = _calculateAspectRatio(screenWidth);
    return LayoutBuilder(builder: (_, constraints) {
      final screenSizeCategory = _categorizeScreenSize(context);
      return _buildWidget(screenSizeCategory);
    });
  }

/// google pixel 2 (height) => 707
/// iphone se 3g (height) => 667
/// iphone 15 (height) => 852
/// Tecno KI5q (height) => 962
/// Infinix smart 6 (height) => 962


  ScreenSizeCategory _categorizeScreenSize(context) {
    double height = getScreenHeight(context);
    // double screenWidth = MediaQuery.of(context).size.width;
    // bool isTablet = screenWidth > 600;
    log('=======HEIGHT========\n SCREEN HEIGHT: $height \n=======HEIGHT========');
  // Categorize screen size based on width
  if (height <= 700 /*&& !isTablet*/) {
    return ScreenSizeCategory.small;
  } else if (height >= 701 && height <= 1950 /*&& !isTablet*/) {
    return ScreenSizeCategory.medium;
  } else {
    return ScreenSizeCategory.tablet;
  }
}

// ScreenSizeCategory _categorizeScreenSize(double width, double height, context) {
//   // Categorize screen size based on width and height
//   if (width <= 414 && height <= 707) {
//     return ScreenSizeCategory.small;
//   } else if (width <= 768 && height <= 852) {
//     return ScreenSizeCategory.medium;
//   } else {
//     return ScreenSizeCategory.tablet;
//   }
// }



  Widget _buildWidget(ScreenSizeCategory screenSizeCategory) {
    // Select the appropriate widget based on screen size category
    switch (screenSizeCategory) {
      case ScreenSizeCategory.small:
        return small;
      case ScreenSizeCategory.medium:
        return medium;
      case ScreenSizeCategory.tablet:
        return tablet ?? Container(); // Return an empty container if large widget is null
    }
  }
}
