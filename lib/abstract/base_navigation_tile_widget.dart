import 'package:flutter/material.dart';

class BaseNavigationTileWidget extends StatelessWidget {
  const BaseNavigationTileWidget({
    super.key,
    required this.pageToNavigate,
    required this.child,
  });

  final Widget pageToNavigate;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => pageToNavigate)
        );
      },
      child: child,
    );
  }
}
