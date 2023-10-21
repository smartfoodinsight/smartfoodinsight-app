import 'package:smartfoodinsight_app/models/models.dart';

abstract class IKeyStorageService {
  Future<void> toggleProductAsync(ProductDetail productDetail);
  Future<bool> isFavoriteProductAsync(String barCode);
  Future<List<ProductDetail>> loadProductsAsync(
      {int limit = 10, int offset = 0});

  Future<void> deleteSecureData(String key);
  Future<String?> readSecureData(String key);
  Future<void> writeSecureData(String key, String value);

  Future<void> setKeyValue<T>(String key, T value);
  Future<T?> getValue<T>(String key);
  Future<bool> removeKey(String key);
}
