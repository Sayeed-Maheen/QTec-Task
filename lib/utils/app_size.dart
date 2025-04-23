import 'package:flutter/material.dart';

class AppSize {
  AppSize._();

  static Size? _size; // Make nullable to handle initialization
  static const double _xdHeight = 882;
  static const double _xdWidth = 375;

  // Initialize size using BuildContext
  static void initialize(BuildContext context) {
    _size = MediaQuery.sizeOf(context);
  }

  // Getter for size with fallback
  static Size get size {
    if (_size == null) {
      // Fallback to a default size if not initialized
      debugPrint('AppSize.size not initialized. Using fallback size.');
      return const Size(375, 882);
    }
    return _size!;
  }

  static double height({required num value}) {
    // Ensure size.height is positive to avoid division issues
    final screenHeight = size.height.clamp(1.0, double.infinity);
    return (value / _xdHeight) * screenHeight;
  }

  static double width({required num value}) {
    // Ensure size.width is positive to avoid division issues
    final screenWidth = size.width.clamp(1.0, double.infinity);
    return (value / _xdWidth) * screenWidth;
  }
}

class ResponsiveUtils {
  ResponsiveUtils._();

  static double _screenHeight = 0;
  static double _screenWidth = 0;
  static const double _referenceHeight = 882; // Same as AppSize
  static const double _referenceWidth = 375; // Same as AppSize

  static void initialize(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    _screenHeight = size.height;
    _screenWidth = size.width;
  }

  // Function to calculate responsive height
  static double height(double value) {
    if (_screenHeight <= 0) {
      debugPrint(
        'ResponsiveUtils.screenHeight not initialized. Using fallback.',
      );
      return value; // Fallback to input value
    }
    return (value / _referenceHeight) *
        _screenHeight.clamp(1.0, double.infinity);
  }

  // Function to calculate responsive width
  static double width(double value) {
    if (_screenWidth <= 0) {
      debugPrint(
        'ResponsiveUtils.screenWidth not initialized. Using fallback.',
      );
      return value; // Fallback to input value
    }
    return (value / _referenceWidth) * _screenWidth.clamp(1.0, double.infinity);
  }
}
