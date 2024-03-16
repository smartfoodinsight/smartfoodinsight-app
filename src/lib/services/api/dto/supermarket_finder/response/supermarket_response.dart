import 'package:freezed_annotation/freezed_annotation.dart';

part 'supermarket_response.freezed.dart';
part 'supermarket_response.g.dart';

@freezed
class SupermarketResponse with _$SupermarketResponse {
  const factory SupermarketResponse({
    required int id,
    required String name,
  }) = _SupermarketResponse;

  factory SupermarketResponse.fromJson(Map<String, Object?> json) =>
      _$SupermarketResponseFromJson(json);
}
