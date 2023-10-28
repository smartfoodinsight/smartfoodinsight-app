import 'package:openfoodfacts/openfoodfacts.dart';

import 'package:smartfoodinsight_app/models/models.dart';
import 'package:smartfoodinsight_app/services/openfoodfacts/mappers/product_mapper.dart';

class OpenFoodFactsApiService {
  Future<ProductFridge> getProductFridgeAsync(String ean) async {
    if (ean == "new") {
      return ProductFridge();
    }

    final productDetail = await getProductAsync(ean);
    return ProductMapper.toProductFridge(productDetail);
  }

  Future<ProductDetail> getProductAsync(String ean) async {
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
      return ProductMapper.toProductDetail(result.product!);
    } else {
      throw Exception('product not found, please insert data for $ean');
    }
  }
}
