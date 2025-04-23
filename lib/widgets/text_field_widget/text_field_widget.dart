import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qtec_task/constants/app_colors.dart';
import 'package:qtec_task/constants/app_icons_path.dart';
import 'package:qtec_task/utils/app_size.dart';
import 'package:qtec_task/widgets/icon_widget/icon_widget.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;
  final Function(String)? onChanged; // Add onChanged parameter

  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged, // Initialize onChanged
  });

  @override
  Widget build(BuildContext context) {
    final double borderWidth = max(
      1.0,
      ResponsiveUtils.width(1).clamp(0.0, double.infinity),
    );

    final double fontSize =
        ResponsiveUtils.width(14).isFinite
            ? ResponsiveUtils.width(14).clamp(12.0, 16.0)
            : 14.0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: const TextStyle(color: AppColors.black),
        onChanged: onChanged,
        // Pass onChanged to TextFormField
        decoration: InputDecoration(
          fillColor: AppColors.white,
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.grey400,
            fontWeight: FontWeight.w300,
            fontSize: fontSize,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: IconWidget(
              height: 20,
              width: 20,
              icon: AppIconsPath.searchIcon,
            ),
          ),
          contentPadding: EdgeInsets.all(ResponsiveUtils.width(18)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.grey300,
              width: borderWidth,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.grey300,
              width: borderWidth,
            ),
          ),
        ),
      ),
    );
  }
}
