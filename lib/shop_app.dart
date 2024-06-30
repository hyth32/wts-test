import 'package:flutter/material.dart';

import 'router/router.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop',
      routes: routes,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[900],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[900],
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
            bodyMedium: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
            labelSmall: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w300
            )
          )),
    );
  }
}
