import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/button.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/product_provider.dart';
import 'package:shop_app/pages/categories_page.dart';
import 'package:shop_app/service/db_helper.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  DBHelper? dbhelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    void removeFromCart(Product product) {
      Provider.of<ProductProvider>(context, listen: false)
          .removeItemFromCart(product);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Ürün Sepetten Kaldırıldı'),
        duration: const Duration(milliseconds: 1000),
        backgroundColor: Colors.pink[200],
      ));
    }

    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        backgroundColor: Colors.pink[200],
        title: const Text("Ürün Sepeti"),
      ),
      body: _buildBody(removeFromCart),
    );
  }

  Center _buildBody(void Function(Product product) removeFromCart) {
    return Center(
      child: Consumer<ProductProvider>(
        builder: (context, value, child) => Container(
          decoration: BoxDecoration(color: Colors.grey[200]),
          child: SafeArea(
              child: FutureBuilder(
                  future: value.getProductList(),
                  builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return Container();
                      } else {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            Expanded(
                              child: cartList(value, removeFromCart),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            _amounText(value),
                            const SizedBox(
                              height: 10,
                            ),
                            sellButton(value, snapshot, context),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        );
                      }
                    } else {
                      return Container();
                    }
                  })),
        ),
      ),
    );
  }

  ShoppingButton sellButton(ProductProvider value,
      AsyncSnapshot<List<Product>> snapshot, BuildContext context) {
    return ShoppingButton(
        onTap: () {
          updateProductQuantity(value, snapshot);
        },
        text: "Satın Al");
  }

  void updateProductQuantity(
      ProductProvider value, AsyncSnapshot<List<Product>> snapshot) {
    Map<int, int> productCounts = {};
    bool? isError = false;
    for (var product in value.userCart) {
      if (productCounts.containsKey(product.id)) {
        productCounts[product.id!] = productCounts[product.id!]! + 1;
      } else {
        productCounts[product.id!] = 1;
      }
    }
    for (var updateProduct in productCounts.keys.toList()) {
      var tempProduct =
          snapshot.data!.where((element) => element.id == updateProduct).first;
      if (tempProduct.quantity! >= productCounts.values.first) {
        dbhelper!.updatequantity(Product(
            id: tempProduct.id,
            price: tempProduct.price,
            productType: tempProduct.productType,
            quantity: tempProduct.quantity! - productCounts.values.first,
            name: tempProduct.name,
            imagePath: tempProduct.imagePath));
      } else {
        isError = true;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Yeterli Stok Bulunamadı'),
          duration: const Duration(milliseconds: 2000),
          backgroundColor: Colors.red[200],
        ));
        break;
      }
    }
    if (!isError!) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Bilgilendirme Mesajı'),
                content:
                    const Text('Satın alma işlemi başarıyla gerçekleştirildi.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        )),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context, 'OK');
                      Provider.of<ProductProvider>(context, listen: false)
                          .removeAllItemFromCart();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) =>
                                  const CategoriesPage()),
                          (route) => false);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ));
    }
  }

  Padding _amounText(ProductProvider value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Toplam Tutar: ${value.total.toString()} TL",
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  ListView cartList(
      ProductProvider value, void Function(Product product) removeFromCart) {
    return ListView.builder(
      itemCount: value.userCart.toSet().length,
      itemBuilder: (context, index) {
        Product eachProduct = value.userCart[index];
        return Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.only(bottom: 5),
            padding: const EdgeInsets.all(5),
            child: ListTile(
              title: Text(
                eachProduct.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${eachProduct.price.toString()} TL",
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
              leading: Image.asset(eachProduct.imagePath),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => removeFromCart(eachProduct),
              ),
            ),
          ),
        );
      },
    );
  }
}
