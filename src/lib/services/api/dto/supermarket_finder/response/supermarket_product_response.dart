import 'package:freezed_annotation/freezed_annotation.dart';

part 'supermarket_product_response.freezed.dart';
part 'supermarket_product_response.g.dart';

@freezed
class SupermarketProductResponse with _$SupermarketProductResponse {
  const factory SupermarketProductResponse({
    required int id,
    required String market,
    required String name,
    required String ean13,
    required String image,
    required String price,
    required String priceUnit,
  }) = _SupermarketProductResponse;

  factory SupermarketProductResponse.fromJson(Map<String, Object?> json) =>
      _$SupermarketProductResponseFromJson(json);
}
