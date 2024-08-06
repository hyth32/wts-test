import 'package:flutter/material.dart';
import 'package:wts_test/abstract/base_tile.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';

class ProductDetailsTile extends BaseTile {
  const ProductDetailsTile({
    required this.product,
    required super.title,
    super.price,
    super.shouldBeScrollable = true,
    super.imageUrl,
    super.key,
  });

  final Product product;

  @override
  Widget buildBody(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Описание${product.productDescription.isNotEmpty ? ':\n${product.productDescription}' : 'отсутствует.'}',
      ),
      const SizedBox(height: 12),
      buildDecoratedText(
          'Рейтинг${product.rating != null ? ': ${product.rating}' : ' недоступен'}'),
      const SizedBox(height: 8),
      buildDecoratedText('${product.isAvailable ? 'Есть' : 'Нет'} в продаже'),
    ]);
  }
}
