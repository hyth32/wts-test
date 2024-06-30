import 'package:flutter/material.dart';
import 'package:wts_test/widgets/widgets.dart';

import '../../models/models.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          product.imageUrl != null && product.imageUrl!.isNotEmpty
              ? Image.network(product.imageUrl!)
              : const NoImageWidget(),
          Text(product.title),
          Text('${product.price}'),
        ],
      ),
    );
  }
}
