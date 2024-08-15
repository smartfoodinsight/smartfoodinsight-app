import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/models/models.dart';

part 'products_provider.g.dart';

@riverpod
class ProductsNotifier extends _$ProductsNotifier {
  int page = 0;
  int lengthProducts = 10;
  bool loadMore = false;

  @override
  FutureOr<MyProduct> build() async {
    final products = await _productsAsync();
    final lastPage = products.length < lengthProducts;
    return MyProduct(products: products, lastPage: lastPage);
  }

  Future<void> nextPageAsync() async {
    final myProduct = state.value;

    if (loadMore || myProduct?.lastPage == true) return;

    loadMore = true;

    await update((myProduct) async {
      final newProducts = await _productsAsync();

      if (newProducts.isEmpty) {
        myProduct.lastPage = true;
        return myProduct;
      }

      myProduct.products.addAll(newProducts);

      if (newProducts.length < lengthProducts) {
        myProduct.lastPage = true;
      }

      return myProduct;
    });

    loadMore = false;
  }

  Future<void> toggleProductAsync(ProductDetail productDetail) async {
    final keyStorageService = ref.read(keyStorageServiceProvider);
    await keyStorageService.toggleProductAsync(productDetail);

    await update((myProduct) {
      final bool existsProduct = myProduct.products
          .any((product) => product.barCode == productDetail.barCode);

      if (existsProduct) {
        myProduct.products
            .removeWhere((product) => product.barCode == productDetail.barCode);
      } else {
        myProduct.products.add(productDetail);
      }
      return myProduct;
    });
  }

  Future<List<ProductDetail>> _productsAsync() async {
    final keyStorageService = ref.read(keyStorageServiceProvider);
    await Future.delayed(const Duration(milliseconds: 500));
    final products = await keyStorageService.loadProductsAsync(
        offset: page * lengthProducts);
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
