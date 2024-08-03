import 'package:flutter/material.dart';
import 'package:wts_test/features/categories/view/categories_screen.dart';
import 'package:wts_test/theme.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop',
      theme: theme,
      home: const CategoriesScreen(),
    );
  }
}
