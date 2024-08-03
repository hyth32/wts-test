import 'package:flutter/material.dart';

class BaseRefreshScaffold extends StatelessWidget {
  const BaseRefreshScaffold({
    super.key,
    required this.appBarTitle,
    required this.body,
    required this.onRefresh,
  });

  final String appBarTitle;
  final Widget body;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: body,
      ),
    );
  }
}
