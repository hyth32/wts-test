import 'package:flutter/material.dart';
import 'package:wts_test/repositories/category/models/category_model.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(category.title),
            const SizedBox(width: 6),
            const Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 18,
            )
          ],
        ),
      )
    );
  }
}
