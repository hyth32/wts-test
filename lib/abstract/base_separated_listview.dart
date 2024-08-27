import 'package:flutter/material.dart';

class BaseSeparatedListview extends StatelessWidget {
  const BaseSeparatedListview({
    required this.buildContent,
    required this.itemCount,
    required this.separator,
    super.key,
    this.scrollController,
    this.edgeInsets,
  });

  final ScrollController? scrollController;
  final Widget Function(BuildContext context, int index) buildContent;
  final int itemCount;
  final Widget separator;
  final double? edgeInsets;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: buildContent,
      separatorBuilder: (BuildContext context, int index) => separator,
      padding: EdgeInsets.all(edgeInsets ?? 16),
      itemCount: itemCount,
    );
  }
}
