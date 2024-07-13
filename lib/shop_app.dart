import 'package:flutter/material.dart';
import 'package:wts_test/theme.dart';

import 'features/categories/view/categories_screen_view.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop',
      // routes: routes,
      theme: theme,
      home: const CategoriesScreen(),
    );
  }
}
