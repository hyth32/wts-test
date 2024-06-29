import 'package:flutter/material.dart';
import 'package:wts_test/features/product/widgets/widgets.dart';
import 'package:wts_test/repositories/product/product.dart';


class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.item, required this.onTap});

  final Product item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          item.imageUrl != null && item.imageUrl!.isNotEmpty ?
          Image.network(item.imageUrl!) : const NoImageWidget(),
          Text(item.title),
          Text('${item.price}'),
        ],
      ),
    );
  }
}