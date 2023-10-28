import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/models/models.dart';

part 'my_fridge_page_provider.g.dart';

@Riverpod(keepAlive: true)
class MyFridgeNotifier extends _$MyFridgeNotifier {
  int page = 0;

  @override
  FutureOr<List<ProductFridge>> build() {
    return _productsFridgeAsync();
  }

  Future<void> toggleProductFridgeAsync(ProductFridge productFridge) async {
    final keyStorageService = ref.read(keyStorageServiceProvider);
    await keyStorageService.toggleProductFridgeAsync(productFridge);

    await update((productsFridge) {
      final bool existsProduct = productsFridge
          .any((product) => product.isarId == productFridge.isarId);

      if (existsProduct) {
        productsFridge
            .removeWhere((product) => product.isarId == productFridge.isarId);
      } else {
        productsFridge.add(productFridge);
      }
      return productsFridge;
    });
  }

  Future<List<ProductFridge>> _productsFridgeAsync() async {
    final keyStorageService = ref.read(keyStorageServiceProvider);
    await Future.delayed(const Duration(seconds: 1));
    final productsFridge =
        await keyStorageService.loadProductsFridgeAsync(offset: page * 10);
    page++;
    return productsFridge;
  }
}

@riverpod
class AddMyFridgeNotifier extends _$AddMyFridgeNotifier {
  @override
  FutureOr<ProductFridge> build(String ean) {
    if (ean == "new") {
      return ProductFridge();
    }
    return _myFridge(ean);
  }

  void updateImage(String image) {
    update((productFridge) {
      productFridge.image = image;
      return productFridge;
    });
  }

  void onDateChanged(String date) {
    update((productFridge) {
      productFridge.date = date;
      return productFridge;
    });
  }

  void onNameChanged(String name) {
    update((productFridge) {
      productFridge.name = name;
      return productFridge;
    });
  }

  Future<ProductFridge> _myFridge(String ean) async {
    final openFoodFactsApiService = ref.read(openFoodFactsApiServiceProvider);
    return openFoodFactsApiService.getProductFridgeAsync(ean);
  }
}
