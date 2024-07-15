import 'package:flutter/cupertino.dart';

class BaseGridviewBuilder extends StatelessWidget {
  const BaseGridviewBuilder({
    super.key,
    required this.buildContent,
    required this.itemCount,
    this.edgeInsets,
  });

  final Widget Function(BuildContext context, int index) buildContent;
  final int itemCount;
  final double? edgeInsets;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(edgeInsets ?? 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 2.25,
      ),
      itemCount: itemCount,
      itemBuilder: buildContent,
    );
  }
}
