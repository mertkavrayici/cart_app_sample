import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/app_bar.dart';
import 'package:shop_app/components/container.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/shopping.dart';
import 'package:shop_app/pages/cart_page.dart';
import 'package:shop_app/pages/products_page.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Shopping>(
      builder: (context, value, child) => Scaffold(
        appBar: const ShoppAppBar(
          appbarTitle: "Kategoriler",
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: value.categories.length,
                      itemBuilder: (context, index) {
                        Product eachCategory = value.categories[index];
                        return ProductContainer(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductsPage(
                                          categoryName: eachCategory.name,
                                          productType:
                                              eachCategory.productType!,
                                        )));
                          },
                          title: eachCategory.name,
                          imagePath: eachCategory.imagePath,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
