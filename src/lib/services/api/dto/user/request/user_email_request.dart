import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_email_request.freezed.dart';
part 'user_email_request.g.dart';

@freezed
class UserEmailRequest with _$UserEmailRequest {
  const factory UserEmailRequest({
    required String email,
  }) = _UserEmailRequest;

  factory UserEmailRequest.fromJson(Map<String, Object?> json) =>
      _$UserEmailRequestFromJson(json);
}
