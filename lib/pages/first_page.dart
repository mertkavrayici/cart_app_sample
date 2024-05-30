import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/button.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/product_provider.dart';
import 'package:shop_app/pages/categories_page.dart';
import 'package:shop_app/service/db_helper.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  DBHelper? dbhelper = DBHelper();
  @override
  void initState() {
    var productList = Provider.of<ProductProvider>(context, listen: false).productList;
    dbhelper!.getProductList().then((list) {
      if (list.isEmpty) {
        for (Product item in productList) {
          dbhelper!.insert(item);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Center(
                child: Text(
              "Alışveriş Uygulaması",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[200]),
            )),
            Center(
                child: Image.asset(
              "lib/images/mall.png",
              height: 350,
            )),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 50,
            ),
            ShoppingButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CategoriesPage()),
                  );
                },
                text: "Giriş Yap")
          ],
        ));
  }
}
