import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5_mobile/generated/colors.gen.dart';

class ParagraphText extends StatelessWidget {
  const ParagraphText({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.textAlign,
    this.fontWeight, this.letterSpacing,
  });

  final String text;
  final Color? color;
  final double? size;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? ColorName.muted,
        fontFamily: 'Inter',
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: size ?? 14.sp,
        letterSpacing: letterSpacing ?? 0
      ),
      textAlign: textAlign ?? TextAlign.left,

    );
  }
}