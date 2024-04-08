import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_google_request.freezed.dart';
part 'login_google_request.g.dart';

@freezed
class LoginGoogleRequest with _$LoginGoogleRequest {
  const factory LoginGoogleRequest({
    required String? idToken,
  }) = _LoginGoogleRequest;

  factory LoginGoogleRequest.fromJson(Map<String, Object?> json) =>
      _$LoginGoogleRequestFromJson(json);
}
