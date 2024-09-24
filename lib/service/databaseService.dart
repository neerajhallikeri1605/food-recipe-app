

import 'package:new_food_app/modal/productsInCart.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseService{

  static final DataBaseService instance = DataBaseService.constructor();

  static Database? _db;
  DataBaseService.constructor();

  Future<Database?> get database async{
    if(_db != null){
      return _db!;
    }
    _db = await getDatabase();
    return _db;
  }
    final String productsTableName = "products";
    final String productsIdName = "id";
    final String productsProductName = "product_name";
    final String productsProductPrice = "product_price";

  Future<Database> getDatabase() async{

    final databaseDirPath =  await getDatabasesPath();

    final databasePath = join(databaseDirPath, "master_db.db");

    final database = await openDatabase(
        databasePath,
      version: 1,
      onCreate: (db, version){
          db.execute('''
            CREATE TABLE $productsTableName(
              $productsIdName INTEGER PRIMARY KEY,
              $productsProductName TEXT NOT NULL,
              $productsProductPrice INTEGER 
            )
            
          ''');
      }
    );
    return database;
  }
  void addproduct(
      String title,
      String price,
      ) async {
    final db = await database;
    await db?.insert(productsTableName, {
      productsProductName : title,
      productsProductPrice: price
    });
  }

  Future<List<CartProducts>?> getproduct() async {
    final db = await database;
    final data = await db?.query(productsTableName);
    print(data);
    List<CartProducts> cartProductsAdded = data?.map((e) => CartProducts(
      id: e['id'] as int,
      productName: e['product_name'] as String,
      productPrice: e['product_price'] as String,
    )).toList() ?? [];
    return cartProductsAdded;
  }


}

