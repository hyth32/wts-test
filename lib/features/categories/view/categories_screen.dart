import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/features/categories/widgets/widgets.dart';
import 'package:wts_test/repositories/category/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category>? _categories;

  @override
  void initState() {
    _loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Категории'),
      ),
      body: _categories == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: _categories!.length,
              itemBuilder: (context, index) {
                Category category = _categories![index];
                return CategoryTile(
                    category: category,
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/list', arguments: category);
                    });
              }),
    );
  }

  void _loadCategories() async {
    _categories = await GetIt.instance<CategoryRepository>().getCategoriesList();
    setState(() {});
  }
}
