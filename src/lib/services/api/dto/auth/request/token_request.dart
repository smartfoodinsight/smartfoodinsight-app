import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_request.freezed.dart';
part 'token_request.g.dart';

@freezed
class TokenRequest with _$TokenRequest {
  const factory TokenRequest({
    required String id,
    required String token,
  }) = _TokenRequest;

  factory TokenRequest.fromJson(Map<String, Object?> json) =>
      _$TokenRequestFromJson(json);
}
