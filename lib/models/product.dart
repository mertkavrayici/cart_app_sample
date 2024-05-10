class Product {
  String name;
  int? price;
  String imagePath;
  int? quantity;
  int? productType;

  Product({
    required this.name,
     this.price,
    required this.imagePath,
     this.quantity,
     this.productType
  });

//veri dönüşümü
  factory Product.fromMap(Map<dynamic, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      imagePath: map['imagePath'] ?? '',
      quantity: map['quantity'] ?? '',
      productType: map['productType'] ?? ''
    );
  }
}
