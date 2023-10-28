import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/models/models.dart';

part 'my_fridge_page_provider.g.dart';

@riverpod
class MyFridgeNotifier extends _$MyFridgeNotifier {
  @override
  FutureOr<ProductFridge> build(String ean) {
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
