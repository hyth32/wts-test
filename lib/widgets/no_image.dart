import 'package:flutter/material.dart';

class NoImageWidget extends StatelessWidget {
  const NoImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(16),
      ),
      constraints: const BoxConstraints(minHeight: 150, minWidth: 100),
      child: const Center(
          child: Text(
        'No image',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
      )),
    );
  }
}
