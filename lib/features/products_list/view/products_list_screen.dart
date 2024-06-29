import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/features/products_list/widgets/widgets.dart';
import 'package:wts_test/repositories/category/category.dart';
import 'package:wts_test/repositories/product/product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product>? _items;
  Category? category;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is Category, 'Invalid arguments');
    category = args as Category;
    setState(() {});
    _loadProducts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${category?.title}'),
      ),
      body: _items == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
              padding: const EdgeInsets.all(12),
              itemCount: _items!.length,
              itemBuilder: (context, index) {
                final item = _items![index];
                return ProductTile(
                  item: item,
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/product', arguments: item);
                  },
                );
              }),
    );
  }

  Future<void> _loadProducts() async {
    _items = await GetIt.instance<ProductRepository>()
        .getProductsList(categoryId: category?.categoryId);
    setState(() {});
  }
}
