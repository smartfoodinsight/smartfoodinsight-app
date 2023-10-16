import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartfoodinsight_app/services/openfoodfacts/openfoodfacts_api_service_provider.dart';

part 'products_details_page_provider.g.dart';

@riverpod
Future<Product> productInfo(ProductInfoRef ref, String ean) async {
  final openFoodFactsApiService = ref.read(openFoodFactsApiServiceProvider);
  final product = await openFoodFactsApiService.getProductAsync(ean);
  return product ?? Product();
}
