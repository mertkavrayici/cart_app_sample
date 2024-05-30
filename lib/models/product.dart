class Product {
   late final int? id;
  String name;
  int? price;
  String imagePath;
  int? quantity;
  int? productType;

  Product({
     this.id,
    required this.name,
     this.price,
    required this.imagePath,
     this.quantity,
     this.productType
  });

//veri dönüşümü
  Product.fromMap(Map<dynamic, dynamic>  res):
  id = res['id'],
  price  = res['price'],
  name = res['name'],
  imagePath = res['imagePath'],
  quantity = res['quantity'],
  productType = res['productType'];

  Map<String , Object?> toMap(){
    return {
      'id': id,
      'price' : price,
      'name' : name,
      'imagePath' : imagePath,
      'quantity' : quantity,
      'productType' : productType,

    };
  }
}
