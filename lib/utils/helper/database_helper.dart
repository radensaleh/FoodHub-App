import 'package:food_hub_app/data/models/restaurant_detail.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static late Database _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tableRestaurantFavorite = 'restaurantFavorite';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant-favorite.db',
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableRestaurantFavorite (
            id TEXT PRIMARY KEY,
            name TEXT,
            city TEXT,
            pictureId TEXT,
            rating REAL
          )
        ''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<void> insertFavorite(RestaurantDetail restaurantDetail) async {
    final db = await database;
    final insert = await db.insert(
      _tableRestaurantFavorite,
      restaurantDetail.toMap(),
    );
    print('Add Favorite $insert');
  }

  Future<List<RestaurantDetail>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results =
        await db.query(_tableRestaurantFavorite);

    final getList =
        results.map((res) => RestaurantDetail.fromMap(res)).toList();

    print('Get Favorite Data $getList');
    return getList;
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableRestaurantFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> updateFavorite(RestaurantDetail restaurantDetail) async {
    final db = await database;

    final update = await db.update(
      _tableRestaurantFavorite,
      restaurantDetail.toMap(),
      where: 'id = ?',
      whereArgs: [restaurantDetail.id],
    );
    print('Update Favorite $update');
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    final delete = await db.delete(
      _tableRestaurantFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
    print('Delete Favorite $delete');
  }
}
