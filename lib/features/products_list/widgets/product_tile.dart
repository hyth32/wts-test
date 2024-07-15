import 'package:flutter/material.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';
import 'package:wts_test/widgets/no_image.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[850], borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            product.imageUrl != null && product.imageUrl!.isNotEmpty
                ? Image.network(product.imageUrl!)
                : const NoImageWidget(),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(product.title,
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text('${product.price} ₽',
                      style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
