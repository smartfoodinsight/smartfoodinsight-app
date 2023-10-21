import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:smartfoodinsight_app/models/models.dart';

class ProductMapper {
  static ProductDetail toProductDetail(Product product) {
    String kCal = _formatNutrient(
        product.nutriments
            ?.getValue(Nutrient.energyKCal, PerSize.oneHundredGrams),
        'kcal');

    String fats = _formatNutrient(
        product.nutriments?.getValue(Nutrient.fat, PerSize.oneHundredGrams),
        'g');

    String saturatedFats = _formatNutrient(
        product.nutriments
            ?.getValue(Nutrient.saturatedFat, PerSize.oneHundredGrams),
        'g');

    String carbohydrates = _formatNutrient(
        product.nutriments
            ?.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams),
        'g');

    String sugars = _formatNutrient(
        product.nutriments?.getValue(Nutrient.sugars, PerSize.oneHundredGrams),
        'g');

    String fiber = _formatNutrient(
        product.nutriments?.getValue(Nutrient.fiber, PerSize.oneHundredGrams),
        'g');

    String proteins = _formatNutrient(
        product.nutriments
            ?.getValue(Nutrient.proteins, PerSize.oneHundredGrams),
        'g');

    String salt = _formatNutrient(
        product.nutriments?.getValue(Nutrient.salt, PerSize.oneHundredGrams),
        'g');

    return ProductDetail(
        barCode: product.barcode!,
        name: product.productName ?? '?',
        quantity: product.quantity ?? '?',
        nutrimentDataPer: product.nutrimentDataPer ?? '?',
        imageFrontUrl: product.imageFrontUrl,
        nutriscore:
            'assets/images/nutriscore-${product.nutriscore ?? 'unknown'}.png',
        novaGroup:
            'assets/images/nova-group-${product.novaGroup ?? 'unknown'}.png',
        ecoscoreGrade:
            'assets/images/ecoscore-${product.ecoscoreGrade ?? 'unknown'}.svg',
        kCal: kCal,
        fats: fats,
        saturatedFats: saturatedFats,
        carbohydrates: carbohydrates,
        sugars: sugars,
        fiber: fiber,
        proteins: proteins,
        salt: salt);
  }

  static String _formatNutrient(double? value, String unit) {
    if (value != null) {
      String formattedValue =
          value % 1 == 0 ? value.toInt().toString() : value.toString();
      return '$formattedValue $unit';
    } else {
      return '?';
    }
  }
}
