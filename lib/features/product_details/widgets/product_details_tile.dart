import 'package:flutter/cupertino.dart';
import 'package:wts_test/features/models/models.dart';

class ProductDetailsTile extends StatelessWidget {
  const ProductDetailsTile({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(product.title),
        const Text('IT WORKS'),
      ],
    ));
  }
}
