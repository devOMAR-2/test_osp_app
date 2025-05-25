import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CustomBoxShadow extends BoxShadow {
  final bool inset;

  const CustomBoxShadow({
    super.color,
    super.offset,
    super.blurRadius,
    super.spreadRadius,
    this.inset = false,
  });

  @override
  Paint toPaint() {
    final Paint result = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(
        BlurStyle.normal,
        blurRadius,
      );

    // التحقق إذا كان `inset` مفعلاً
    if (inset) {
      result.colorFilter = ui.ColorFilter.mode(color, ui.BlendMode.srcIn);
    }

    return result;
  }
}
