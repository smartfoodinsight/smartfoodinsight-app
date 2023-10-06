import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request.freezed.dart';

@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    String? email,
    String? password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, Object?> json) =>
      _$LoginRequestFromJson(json);
}
