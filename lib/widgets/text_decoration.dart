import 'package:flutter/material.dart';

class TextDecorationWidget extends StatelessWidget {
  const TextDecorationWidget({
    super.key,
    required this.text,
    this.backgroundColor,
    this.verticalInset,
    this.borderRadius,
  });

  final String text;
  final Color? backgroundColor;
  final double? verticalInset;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        color: backgroundColor ?? Colors.grey[850],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: verticalInset != null ? verticalInset! * 2 : 8,
          right: verticalInset != null ? verticalInset! * 2 : 8,
          top: verticalInset ?? 2,
          bottom: verticalInset ?? 2,
        ),
        child: Text(text),
      ),
    );
  }
}
