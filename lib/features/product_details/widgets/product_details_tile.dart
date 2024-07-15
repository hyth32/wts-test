import 'package:flutter/material.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';
import 'package:wts_test/widgets/no_image.dart';
import 'package:wts_test/widgets/text_decoration.dart';

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
            Text(
              'Количество фотографий: ${product.images?.length}',
            ),
            const SizedBox(height: 32),
            Text(
              product.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              '${product.price} ₽',
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Описание${product.productDescription.isNotEmpty ? ':\n${product.productDescription}' : 'отсутствует.'}',
            ),
            const SizedBox(
              height: 12,
            ),
            TextDecoration(
              text:
                  'Рейтинг${product.rating != null ? ': ${product.rating}' : ' недоступен'}',
              verticalInset: 6,
            ),
            const SizedBox(height: 8),
            TextDecoration(
              text: '${product.isAvailable ? 'Есть' : 'Нет'} в продаже',
              verticalInset: 6,
            ),
          ]),
        ));
  }
}
