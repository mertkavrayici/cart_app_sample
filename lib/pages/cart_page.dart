import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/button.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/shopping.dart';
import 'package:shop_app/pages/categories_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    void removeFromCart(Product product) {
      Provider.of<Shopping>(context, listen: false).removeItemFromCart(product);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Ürün Sepetten Kaldırıldı'),
        duration: const Duration(milliseconds: 1500),
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
      body: Center(
        child: Consumer<Shopping>(
          builder: (context, value, child) => Container(
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: value.userCart.length,
                      itemBuilder: (context, index) {
                        Product eachProduct = value.userCart[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.only(bottom: 5),
                            padding: const EdgeInsets.all(5),
                            child: ListTile(
                              title: Text(
                                eachProduct.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${eachProduct.price.toString()} TL",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700),
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
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Toplam Tutar: ${value.total.toString()} TL",
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ShoppingButton(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Bilgilendirme Mesajı'),
                                  content: const Text(
                                      'Satın alma işlemi başarıyla gerçekleştirildi.',style: TextStyle(color: Colors.black,fontSize: 16,)),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context, 'OK');
                                        Provider.of<Shopping>(context,
                                                listen: false)
                                            .removeAllItemFromCart();
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute<dynamic>(
                                                builder:
                                                    (BuildContext context) =>
                                                        const CategoriesPage()),
                                            (route) => false);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                      },
                      text: "Satın Al"),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
