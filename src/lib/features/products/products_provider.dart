import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/models/models.dart';

part 'products_provider.g.dart';

@riverpod
class ProductsNotifier extends _$ProductsNotifier {
  int page = 0;

  @override
  FutureOr<List<ProductDetail>> build() {
    return _productsAsync();
  }

  Future<void> toggleProductAsync(ProductDetail productDetail) async {
    final keyStorageService = ref.read(keyStorageServiceProvider);
    await keyStorageService.toggleProductAsync(productDetail);

    await update((products) {
      final bool existsProduct =
          products.any((product) => product.barCode == productDetail.barCode);

      if (existsProduct) {
        products
            .removeWhere((product) => product.barCode == productDetail.barCode);
      } else {
        products.add(productDetail);
      }
      return products;
    });
  }

  Future<List<ProductDetail>> _productsAsync() async {
    final keyStorageService = ref.read(keyStorageServiceProvider);
    await Future.delayed(const Duration(milliseconds: 500));
    final products =
        await keyStorageService.loadProductsAsync(offset: page * 10);
    page++;
    return products;
  }
}

@riverpod
Future<bool> isFavoriteProduct(IsFavoriteProductRef ref, String barCode) async {
  final keyStorageService = ref.read(keyStorageServiceProvider);
  return keyStorageService.isFavoriteProductAsync(barCode);
}

@riverpod
Future<ProductDetail> productInfo(ProductInfoRef ref, String ean) async {
  final openFoodFactsApiService = ref.read(openFoodFactsApiServiceProvider);
  return openFoodFactsApiService.getProductAsync(ean);
}
