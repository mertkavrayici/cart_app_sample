import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/service/db_helper.dart';

class ProductProvider extends ChangeNotifier {
  
  final List<Product> _categories = [
    Product(
        name: 'Pantolonlar',
        imagePath: "lib/images/panths.png",
        productType: 1),
    Product(
        name: 'Ceketler', imagePath: "lib/images/jacket.png", productType: 2),
    Product(
        name: 'Ayakkabılar', imagePath: "lib/images/shoes.png", productType: 3),
    Product(
        name: 'Gömlekler', imagePath: "lib/images/skirts.png", productType: 4),
    Product(
        name: 'Tişörtler', imagePath: "lib/images/tshirt.png", productType: 5),
    Product(
        name: 'Aksesuarlar', imagePath: "lib/images/glass.jpg", productType: 6),
  ];
  //Bu liste artık uygulama açılırken database'e kaydediliyor.Sonrasında kullanılmıyor.
   List<Product> _products = [
    Product(
        id: 0,
        name: 'Pantolon 1',
        imagePath: "lib/images/panths.png",
        price: 50,
        quantity: 5,
        productType: 1),
    Product(
        id: 1,
        name: 'Pantolon 2',
        imagePath: "lib/images/panths.png",
        price: 120,
        quantity: 3,
        productType: 1),
    Product(
        id: 2,
        name: 'Pantolon 3',
        imagePath: "lib/images/panths.png",
        price: 180,
        quantity: 10,
        productType: 1),
    Product(
        id: 3,
        name: 'Pantolon 4',
        imagePath: "lib/images/panths.png",
        price: 300,
        quantity: 17,
        productType: 1),
    Product(
      id: 4,
      name: 'Ceket 1',
      imagePath: "lib/images/jacket.png",
      productType: 2,
      price: 250,
      quantity: 22,
    ),
    Product(
      id: 5,
      name: 'Ceket 2',
      imagePath: "lib/images/jacket.png",
      productType: 2,
      price: 480,
      quantity: 8,
    ),
    Product(
      id: 6,
      name: 'Ceket 3',
      imagePath: "lib/images/jacket.png",
      productType: 2,
      price: 720,
      quantity: 2,
    ),
    Product(
      id: 7,
      name: 'Ceket 4',
      imagePath: "lib/images/jacket.png",
      productType: 2,
      price: 1020,
      quantity: 19,
    ),
    Product(
      id: 8,
      name: 'Ayakkabı 1',
      imagePath: "lib/images/shoes.png",
      productType: 3,
      price: 720,
      quantity: 100,
    ),
    Product(
      id: 9,
      name: 'Ayakkabı 2',
      imagePath: "lib/images/shoes.png",
      productType: 3,
      price: 1000,
      quantity: 200,
    ),
    Product(
      id: 10,
      name: 'Ayakkabı 3',
      imagePath: "lib/images/shoes.png",
      productType: 3,
      price: 1200,
      quantity: 21,
    ),
    Product(
      id: 11,
      name: 'Gömlek 1',
      imagePath: "lib/images/skirts.png",
      productType: 4,
      price: 120,
      quantity: 2,
    ),
    Product(
      id: 12,
      name: 'Gömlek 2',
      imagePath: "lib/images/skirts.png",
      productType: 4,
      price: 75,
      quantity: 1,
    ),
    Product(
      id: 13,
      name: 'Gömlek 3',
      imagePath: "lib/images/skirts.png",
      productType: 4,
      price: 220,
      quantity: 19,
    ),
    Product(
      id: 14,
      name: 'Tişört 1',
      imagePath: "lib/images/tshirt.png",
      productType: 5,
      price: 90,
      quantity: 111,
    ),
    Product(
      id: 15,
      name: 'Tişört 2',
      imagePath: "lib/images/tshirt.png",
      productType: 5,
      price: 120,
      quantity: 222,
    ),
    Product(
      id: 16,
      name: 'Tişört 3',
      imagePath: "lib/images/tshirt.png",
      productType: 5,
      price: 280,
      quantity: 3,
    ),
    Product(
      id: 17,
      name: 'Tişört 4',
      imagePath: "lib/images/tshirt.png",
      productType: 5,
      price: 320,
      quantity: 1,
    ),
    Product(
      id: 18,
      name: 'Tişört 5',
      imagePath: "lib/images/tshirt.png",
      productType: 5,
      price: 210,
      quantity: 10,
    ),
    Product(
      id: 19,
      name: 'Gözlük  1',
      imagePath: "lib/images/glass.jpg",
      productType: 6,
      price: 300,
      quantity: 11,
    ),
    Product(
      id: 20,
      name: 'Gözlük 2',
      imagePath: "lib/images/glass.jpg",
      productType: 6,
      price: 500,
      quantity: 12,
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
  
   Future<List<Product>> getProductList() async {
     DBHelper db = DBHelper();
    _products = await db.getProductList();
    return _products;
  }
}
