import 'package:flutter/material.dart';
import 'package:wts_test/models/models.dart';
import 'package:wts_test/widgets/widgets.dart';

class ProductDetailsTile extends StatelessWidget {
  const ProductDetailsTile({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            product.imageUrl != null
                ? Image.network('${product.images?[0]}')
                : const NoImageWidget(),
            const SizedBox(height: 32),
            Text('Количество фотографий: ${product.images?.length}'),
            const SizedBox(height: 32),
            Text(product.title, style: Theme.of(context).textTheme.bodyLarge),
            Text('${product.price} ₽'),
            const SizedBox(
              height: 12,
            ),
            Text(
                'Описание${product.productDescription.isNotEmpty ? ':\n${product.productDescription}' : 'отсутствует.'}'),
            const SizedBox(
              height: 12,
            ),
            TextWithPagination(
              child: Text(
                  'Рейтинг${product.rating != null ? ': ${product.rating}' : ' недоступен'}'),
            ),
            const SizedBox(height: 8),
            TextWithPagination(
              child: Text(
                  '${product.isAvailableForSale ? 'Есть' : 'Нет'} в продаже'),
            ),
          ]),
        ));
  }
}
