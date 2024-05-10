import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';

class Shopping extends ChangeNotifier {
  final List<Product> _categories = [
    Product(
      name: 'Pantolonlar',
      imagePath: "lib/images/panths.png",
      productType: 1
    ),
    Product(
      name: 'Ceketler',
      imagePath: "lib/images/jacket.png",
      productType: 2
    ),
    Product(
      name: 'Ayakkabılar',
      imagePath: "lib/images/shoes.png",
      productType: 3
    ),
    Product(
      name: 'Gömlekler',
      imagePath: "lib/images/skirts.png",
      productType: 4
    ),
    Product(
      name: 'Tişörtler',
      imagePath: "lib/images/tshirt.png",
      productType: 5
    ),
    Product(
      name: 'Aksesuarlar',
      imagePath: "lib/images/glass.jpg",
      productType: 6
    ),
  ];
    final List<Product> _products = [
    Product(
      name: 'Pantolon 1',
      imagePath: "lib/images/panths.png",
      price: 50,
      quantity: 1,
      productType: 1

    ),
        Product(
      name: 'Pantolon 2',
      imagePath: "lib/images/panths.png",
      price: 120,
      quantity: 1,
      productType: 1

    ),
        Product(
      name: 'Pantolon 3',
      imagePath: "lib/images/panths.png",
      price: 180,
      quantity: 1,
      productType: 1

    ),
        Product(
      name: 'Pantolon 4',
      imagePath: "lib/images/panths.png",
      price: 300,
      quantity: 1,
      productType: 1

    ),
       Product(
      name: 'Ceket 1',
      imagePath: "lib/images/jacket.png",
      productType: 2,
      price: 250,
       quantity: 1,
    ),
       Product(
      name: 'Ceket 2',
      imagePath: "lib/images/jacket.png",
      productType: 2,
      price: 480,
       quantity: 1,
    ),
       Product(
      name: 'Ceket 3',
      imagePath: "lib/images/jacket.png",
      productType: 2,
      price: 720,
       quantity: 1,
    ),
       Product(
      name: 'Ceket 4',
      imagePath: "lib/images/jacket.png",
      productType: 2,
      price: 1020,
       quantity: 1,
    ),
     Product(
      name: 'Ayakkabı 1',
      imagePath: "lib/images/shoes.png",
      productType: 3,
      price: 720,
       quantity: 1,
    ),
     Product(
      name: 'Ayakkabı 2',
      imagePath: "lib/images/shoes.png",
      productType: 3,
      price: 1000,
       quantity: 1,
    ),
     Product(
      name: 'Ayakkabı 3',
      imagePath: "lib/images/shoes.png",
      productType: 3,
      price: 1200,
       quantity: 1,
    ),
       Product(
      name: 'Gömlek 1',
      imagePath: "lib/images/skirts.png",
      productType: 4,
      price: 120,
       quantity: 1,
    ),
       Product(
      name: 'Gömlek 2',
      imagePath: "lib/images/skirts.png",
      productType: 4,
      price: 75,
       quantity: 1,
    ),
       Product(
      name: 'Gömlek 3',
      imagePath: "lib/images/skirts.png",
      productType: 4,
      price: 220,
       quantity: 1,
    ),
        Product(
      name: 'Tişört 1',
      imagePath: "lib/images/tshirt.png",
      productType: 5,
      price: 90,
       quantity: 1,
    ),
        Product(
      name: 'Tişört 2',
      imagePath: "lib/images/tshirt.png",
      productType: 5,
      price: 120,
       quantity: 1,
    ),
        Product(
      name: 'Tişört 3',
      imagePath: "lib/images/tshirt.png",
      productType: 5,
      price: 280,
       quantity: 1,
    ),
        Product(
      name: 'Tişört 4',
      imagePath: "lib/images/tshirt.png",
      productType: 5,
      price: 320,
       quantity: 1,
    ),
        Product(
      name: 'Tişört 5',
      imagePath: "lib/images/tshirt.png",
      productType: 5,
      price: 210,
       quantity: 1,
    ),
      Product(
      name: 'Gözlük  1',
      imagePath: "lib/images/glass.jpg",
      productType: 6,
      price: 300,
       quantity: 1,
    ),
      Product(
      name: 'Gözlük 2',
      imagePath: "lib/images/glass.jpg",
      productType: 6,
      price: 500,
       quantity: 1,
    ),
       
  ];

  //user cart
  final List<Product> _userCart = [];

  List<Product> get categories => _categories;

  //get user cart
  List<Product> get userCart => _userCart;

  List<Product> get productList => _products;

  //total price
  double get total => userCart.fold(0, (sum, item) => sum + item.price!);

  //add item to cart
  void addItemtoCart(Product product) {
    _userCart.add(product);
    notifyListeners();
  }

  //remove item from cart
  void removeItemFromCart(Product product) {
    _userCart.remove(product);
    notifyListeners();
  }
  void removeAllItemFromCart() {
    _userCart.clear();
    notifyListeners();
  }
}
