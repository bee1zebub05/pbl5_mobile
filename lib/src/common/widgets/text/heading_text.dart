
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5_mobile/generated/colors.gen.dart';

class HeadingText extends StatelessWidget {
  const HeadingText({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.textAlign,
    this.fontWeight,
  });

  final String text;
  final Color? color;
  final double? size;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? ColorName.primary,
        fontFamily: 'Public_Sans',
        fontWeight: fontWeight ?? FontWeight.bold,
        fontSize: size ?? 24.sp,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}
