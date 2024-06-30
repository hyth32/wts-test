import 'package:flutter/material.dart';
import 'package:wts_test/models/models.dart';
import 'package:wts_test/widgets/no_image.dart';
import 'package:wts_test/widgets/text_with_pagination.dart';

class ProductDetailsTile extends StatelessWidget {
  const ProductDetailsTile({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        product.imageUrl != null
            ? Image.network('${product.imageUrl}')
            : const NoImageWidget(),
        const SizedBox(height: 32),
        Text(product.title, style: Theme.of(context).textTheme.bodyLarge),
        Text('${product.price} ₽'),
        const SizedBox(height: 12,),
        Text('Description ${product.productDescription.isNotEmpty ? ': ${product.productDescription}' : 'is empty.'}'),
        const SizedBox(height: 12,),
        TextWithPagination(
          child: Text(
              'Rating${product.rating != null ? ': ${product.rating}' : ' is unavailable'}'),
        ),
        const SizedBox(height: 8),
        TextWithPagination(
          child: Text(
              '${product.isAvailableForSale ? 'Available' : 'Not available'} for sale'),
        ),
      ]),
    );
  }
}
