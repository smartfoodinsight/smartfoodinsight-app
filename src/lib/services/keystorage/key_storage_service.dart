import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

import 'package:smartfoodinsight_app/models/models.dart';
import 'package:smartfoodinsight_app/services/services.dart';

class KeyStorageService extends IKeyStorageService {
  late Future<Isar> db;

  KeyStorageService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([ProductDetailSchema, ProductFridgeSchema],
          inspector: true, directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }

  final _storage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<List<ProductFridge>> loadProductsFridgeAsync(
      {int limit = 10, int offset = 0}) async {
    final isar = await db;
    return isar.productFridges.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleProductFridgeAsync(ProductFridge productFridge) async {
    final isar = await db;
    final existsProduct = await isar.productFridges
        .filter()
        .isarIdEqualTo(productFridge.isarId)
        .findFirst();

    if (existsProduct != null) {
      isar.writeTxnSync(
          () => isar.productFridges.deleteSync(existsProduct.isarId!));
    } else {
      isar.writeTxnSync(() => isar.productFridges.putSync(productFridge));
    }
  }

  @override
  Future<bool> isFavoriteProductAsync(String barCode) async {
    final isar = await db;

    final ProductDetail? isFavoriteProduct =
        await isar.productDetails.filter().barCodeEqualTo(barCode).findFirst();

    return isFavoriteProduct != null;
  }

  @override
  Future<List<ProductDetail>> loadProductsAsync(
      {int limit = 10, int offset = 0}) async {
    final isar = await db;
    return isar.productDetails.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleProductAsync(ProductDetail productDetail) async {
    final isar = await db;
    final existsProduct = await isar.productDetails
        .filter()
        .barCodeEqualTo(productDetail.barCode)
        .findFirst();

    if (existsProduct != null) {
      isar.writeTxnSync(
          () => isar.productDetails.deleteSync(existsProduct.isarId!));
    } else {
      isar.writeTxnSync(() => isar.productDetails.putSync(productDetail));
    }
  }

  @override
  Future<void> writeSecureData(String key, String value) async {
    await _storage.write(
        key: key, value: value, aOptions: _getAndroidOptions());
  }

  @override
  Future<String?> readSecureData(String key) async {
    var readData =
        await _storage.read(key: key, aOptions: _getAndroidOptions());
    return readData;
  }

  @override
  Future<void> deleteSecureData(String key) async {
    await _storage.delete(key: key, aOptions: _getAndroidOptions());
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPrefs();

    switch (T) {
      case int:
        return prefs.getInt(key) as T?;
      case String:
        return prefs.getString(key) as T?;
      default:
        throw UnimplementedError(
            'GET not implemented for type ${T.runtimeType}');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();

    switch (T) {
      case int:
        prefs.setInt(key, value as int);
        break;
      case String:
        prefs.setString(key, value as String);
        break;
      default:
        throw UnimplementedError(
            'Set not implemented for type ${T.runtimeType}');
    }
  }
}
