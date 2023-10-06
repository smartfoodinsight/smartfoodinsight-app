import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.freezed.dart';

@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    String? name,
    String? email,
    String? password,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, Object?> json) =>
      _$RegisterRequestFromJson(json);
}
