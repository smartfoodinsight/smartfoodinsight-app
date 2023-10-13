import 'package:openfoodfacts/openfoodfacts.dart';

class OpenFoodFactsApiService {
  Future<Product?> getProduct(String eancode) async {
    OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'Smart Food Insight');

    final ProductQueryConfiguration configuration = ProductQueryConfiguration(
        eancode,
        country: OpenFoodFactsCountry.SPAIN,
        language: OpenFoodFactsLanguage.SPANISH,
        fields: [ProductField.ALL],
        version: ProductQueryVersion.v3);

    final ProductResultV3 result =
        await OpenFoodAPIClient.getProductV3(configuration);

    if (result.status == ProductResultV3.statusSuccess) {
      return result.product;
    } else {
      throw Exception('product not found, please insert data for $eancode');
    }
  }
}
