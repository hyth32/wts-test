import 'package:flutter/material.dart';
import 'package:wts_test/abstract/base_tile.dart';

class ProductTile extends BaseTile {
  const ProductTile({
    required super.title,
    super.imageUrl,
    super.price,
    super.shouldBeScrollable,
    super.key,
  });

  @override
  Widget buildBody(BuildContext context) {
    return const SizedBox();
  }
}
