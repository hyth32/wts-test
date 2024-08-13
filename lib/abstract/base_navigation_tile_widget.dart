import 'package:flutter/material.dart';

class BaseNavigationTileWidget extends StatelessWidget {
  const BaseNavigationTileWidget({
    required this.pageToNavigate,
    required this.child,
    super.key,
  });

  final Widget pageToNavigate;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => pageToNavigate,
          ),
        );
      },
      child: child,
    );
  }
}
