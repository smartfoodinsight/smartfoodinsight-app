import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_request.freezed.dart';
part 'user_request.g.dart';

@freezed
class UserRequest with _$UserRequest {
  const factory UserRequest({
    String? id,
    String? name,
    String? email,
    String? picture,
  }) = _UserRequest;

  factory UserRequest.fromJson(Map<String, Object?> json) =>
      _$UserRequestFromJson(json);
}
