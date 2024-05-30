import 'dart:io' as io;


import 'package:path_provider/path_provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper{
  static Database? _db;


  // Database eğer oluşturulmadıysa oluşturuyor
  Future<Database?> get dbase async{
  
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db;
  }
  initDatabase()async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    
    String path = join(documentDirectory.path, 'product.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }
  // Tabledaki alanlar oluşturduğumuz productModelden geliyor
  _onCreate (Database db , int version) async {
    await db.execute('CREATE TABLE product (id INTEGER PRIMARY KEY , name TEXT , price INTEGER , imagePath String , quantity INTEGER , productType INTEGER , image TEXT)');
  }

  //DB'ye ekleme methodu.Projede başlangıçta listedeki tüm ürünleri bu methodla ekledik.
  Future<Product> insert(Product product)async{
    var dbClient = await dbase;
    await dbClient!.insert('product', product.toMap());
    return product;
  }
//DB'deki ürünleri çağırma methodu
  Future<List<Product>> getProductList()async{
    var dbClient = await dbase;
    final List<Map<String , Object?>> queryresult = await dbClient!.query("product");
    return queryresult.map((e) => Product.fromMap(e)).toList();
  }
//Proje içinde gerek kalmadı kullanmaya -Silme
Future<int> delete (int id)async{
  var dbClient = await dbase;
  return await dbClient!.delete(
    "product",
    where: 'id = ?',
    whereArgs: [id]
    );
}
//Adet sayısı güncelleme methodu-Satışlardan sonra güncelliyoruz.
Future<int> updatequantity(Product product)async{
  var dbClient = await dbase;
  return await dbClient!.update(
    'product',
    product.toMap(),
    where: 'id = ?',
    whereArgs: [product.id],
  );

}
}