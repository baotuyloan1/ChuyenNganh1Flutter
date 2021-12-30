// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CartDAO? _cartDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Cart` (`id` INTEGER NOT NULL, `categoryProduct` INTEGER NOT NULL, `price` INTEGER NOT NULL, `uid` TEXT NOT NULL, `productName` TEXT NOT NULL, `imageUrl` TEXT NOT NULL, `quantity` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CartDAO get cartDao {
    return _cartDaoInstance ??= _$CartDAO(database, changeListener);
  }
}

class _$CartDAO extends CartDAO {
  _$CartDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _cartInsertionAdapter = InsertionAdapter(
            database,
            'Cart',
            (Cart item) => <String, Object?>{
                  'id': item.id,
                  'categoryProduct': item.categoryProduct,
                  'price': item.price,
                  'uid': item.uid,
                  'productName': item.productName,
                  'imageUrl': item.imageUrl,
                  'quantity': item.quantity
                },
            changeListener),
        _cartUpdateAdapter = UpdateAdapter(
            database,
            'Cart',
            ['id'],
            (Cart item) => <String, Object?>{
                  'id': item.id,
                  'categoryProduct': item.categoryProduct,
                  'price': item.price,
                  'uid': item.uid,
                  'productName': item.productName,
                  'imageUrl': item.imageUrl,
                  'quantity': item.quantity
                },
            changeListener),
        _cartDeletionAdapter = DeletionAdapter(
            database,
            'Cart',
            ['id'],
            (Cart item) => <String, Object?>{
                  'id': item.id,
                  'categoryProduct': item.categoryProduct,
                  'price': item.price,
                  'uid': item.uid,
                  'productName': item.productName,
                  'imageUrl': item.imageUrl,
                  'quantity': item.quantity
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Cart> _cartInsertionAdapter;

  final UpdateAdapter<Cart> _cartUpdateAdapter;

  final DeletionAdapter<Cart> _cartDeletionAdapter;

  @override
  Stream<List<Cart>> getAllItemInCartAllByUid(String uid) {
    return _queryAdapter.queryListStream('SELECT * FROM Cart WHERE uid=?1',
        mapper: (Map<String, Object?> row) => Cart(
            id: row['id'] as int,
            uid: row['uid'] as String,
            productName: row['productName'] as String,
            categoryProduct: row['categoryProduct'] as int,
            imageUrl: row['imageUrl'] as String,
            price: row['price'] as int,
            quantity: row['quantity'] as int),
        arguments: [uid],
        queryableName: 'Cart',
        isView: false);
  }

  @override
  Future<Cart?> getItemInCartByUid(String uid, int id) async {
    return _queryAdapter.query('SELECT * FROM Cart WHERE uid=?1 AND id=?2',
        mapper: (Map<String, Object?> row) => Cart(
            id: row['id'] as int,
            uid: row['uid'] as String,
            productName: row['productName'] as String,
            categoryProduct: row['categoryProduct'] as int,
            imageUrl: row['imageUrl'] as String,
            price: row['price'] as int,
            quantity: row['quantity'] as int),
        arguments: [uid, id]);
  }

  @override
  Future<Cart?> clearCartByUid(String uid) async {
    return _queryAdapter.query('DELETE FROM Cart WHERE uid=?1',
        mapper: (Map<String, Object?> row) => Cart(
            id: row['id'] as int,
            uid: row['uid'] as String,
            productName: row['productName'] as String,
            categoryProduct: row['categoryProduct'] as int,
            imageUrl: row['imageUrl'] as String,
            price: row['price'] as int,
            quantity: row['quantity'] as int),
        arguments: [uid]);
  }

  @override
  Future<void> insertCart(Cart product) async {
    await _cartInsertionAdapter.insert(product, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCart(Cart product) async {
    await _cartUpdateAdapter.update(product, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCart(Cart product) async {
    await _cartDeletionAdapter.delete(product);
  }
}
