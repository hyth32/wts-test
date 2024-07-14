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
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey[850],
            height: 1,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: body,
      ),
    );
  }
}