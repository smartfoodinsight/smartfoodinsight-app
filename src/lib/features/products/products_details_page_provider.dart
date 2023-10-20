import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/models/models.dart';

part 'products_details_page_provider.g.dart';

@riverpod
Future<ProductDetail> productInfo(ProductInfoRef ref, String ean) async {
  final openFoodFactsApiService = ref.read(openFoodFactsApiServiceProvider);
  final productDetail = await openFoodFactsApiService.getProductAsync(ean);
  return productDetail;
}
