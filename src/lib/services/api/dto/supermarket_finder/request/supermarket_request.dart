import 'package:freezed_annotation/freezed_annotation.dart';

part 'supermarket_request.freezed.dart';
part 'supermarket_request.g.dart';

@freezed
class SupermarketRequest with _$SupermarketRequest {
  const factory SupermarketRequest({
    required List<int> markets,
    required String term,
  }) = _SupermarketRequest;

  factory SupermarketRequest.fromJson(Map<String, Object?> json) =>
      _$SupermarketRequestFromJson(json);
}
