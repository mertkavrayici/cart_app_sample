import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product_provider.dart';
import 'package:shop_app/pages/first_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FirstPage(),
      ),
    );
  }
}
