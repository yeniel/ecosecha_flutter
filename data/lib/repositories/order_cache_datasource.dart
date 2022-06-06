import 'package:data/dtos/order_product_cache_dto.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class OrderCacheDataSource {
  OrderCacheDataSource() {
    _initDB();
  }

  late Future<Database> database;

  Future<void> _initDB() async {
    WidgetsFlutterBinding.ensureInitialized();

    database = openDatabase(
      join(await getDatabasesPath(), 'ecosecha_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE order_products(id INTEGER PRIMARY KEY, quantity INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<List<OrderProductCacheDto>> getProducts() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('order_products');

    return Future.value(List.generate(maps.length, (index) {
      return OrderProductCacheDto(
        id: maps[index]['id'],
        quantity: maps[index]['quantity'],
      );
    }));
  }

  Future<void> upsertProduct({required OrderProductCacheDto orderProduct}) async {
    final db = await database;

    await db.insert(
      'order_products',
      orderProduct.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteProduct({required int id}) async {
    final db = await database;

    await db.delete(
      'order_products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAll() async {
    final db = await database;

    await db.execute('DELETE FROM order_products');
  }
}
