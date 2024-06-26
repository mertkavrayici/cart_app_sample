import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/app_bar.dart';
import 'package:shop_app/components/container.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/product_provider.dart';

class ProductsPage extends StatefulWidget {
  final int productType;
  final String categoryName;
  const ProductsPage(
      {super.key, required this.productType, required this.categoryName});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    void addToCart(Product product) {
      Provider.of<ProductProvider>(context, listen: false)
          .addItemtoCart(product);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Ürün Sepete Eklendi'),
        duration: const Duration(milliseconds: 2000),
        backgroundColor: Colors.pink[200],
      ));
    }

    return Consumer<ProductProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: ShoppAppBar(
          appbarTitle: widget.categoryName,
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
                  FutureBuilder(
                      future: value.getProductList(),
                      builder:
                          (context, AsyncSnapshot<List<Product>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isEmpty) {
                            return Container();
                          } else {
                            return Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data!
                                    .where((element) =>
                                        element.productType ==
                                        widget.productType)
                                    .toList()
                                    .length,
                                itemBuilder: (context, index) {
                                  Product eachProduct = snapshot.data!
                                      .where((element) =>
                                          element.productType ==
                                          widget.productType)
                                      .toList()[index];
                                  return ProductContainer(
                                    quantity: eachProduct.quantity,
                                    onTap: () {
                                      addToCart(eachProduct);
                                    },
                                    title: eachProduct.name,
                                    imagePath: eachProduct.imagePath,
                                    price: eachProduct.price,
                                  );
                                },
                              ),
                            );
                          }
                        } else {
                          return Container();
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
