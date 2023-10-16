import 'package:openfoodfacts/openfoodfacts.dart';

class OpenFoodFactsApiService {
  Future<Product?> getProductAsync(String ean) async {
    OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'Smart Food Insight');
    OpenFoodAPIConfiguration.globalCountry = OpenFoodFactsCountry.SPAIN;

    final ProductQueryConfiguration configuration = ProductQueryConfiguration(
        ean,
        country: OpenFoodFactsCountry.SPAIN,
        language: OpenFoodFactsLanguage.SPANISH,
        fields: [ProductField.ALL],
        version: ProductQueryVersion.v3);

    final ProductResultV3 result =
        await OpenFoodAPIClient.getProductV3(configuration);

    if (result.status == ProductResultV3.statusSuccess) {
      return result.product;
    } else {
      throw Exception('product not found, please insert data for $ean');
    }
  }
}
