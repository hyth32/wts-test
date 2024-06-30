import 'package:flutter/material.dart';
import 'package:wts_test/features/models/models.dart';
import 'package:wts_test/widgets/widgets.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Product? item;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is Product, 'Invalid arguments');
    item = args as Product;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(item != null ? '${item?.title}' : '...'),
        ),
        body: item == null
            ? const Text('No data')
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _buildItemWidgets().length,
                itemBuilder: (context, index) {
                  return _buildItemWidgets()[index];
                },
              ));
  }

  List<Widget> _buildItemWidgets() {
    return [
      item!.imageUrl != null && item!.imageUrl!.isNotEmpty
          ? Image.network(item!.imageUrl!)
          : const NoImageWidget(),
      Text(
        '${item?.title}',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      Text('Price: ${item?.price}'),
      Text('Rating: ${item?.rating ?? 'No rating'}'),
      Text(
          'Description:\n${item?.productDescription.isEmpty == true ? 'Empty' : item?.productDescription}'),
      Text(
          '${item!.isAvailableForSale ? 'Available' : 'Not available'} for sale'),
    ];
  }
}
