import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smartfoodinsight_app/common/validations/validations.dart';

part 'auth_forms_state.freezed.dart';

@freezed
class AuthFormsState with _$AuthFormsState {
  const factory AuthFormsState({
    @Default(TextFormz.pure()) TextFormz name,
    @Default(EmailFormz.pure()) EmailFormz email,
    @Default(PasswordFormz.pure()) PasswordFormz password,
    @Default(false) bool isFormPosted,
    @Default(false) bool isValid,
  }) = _AuthFormsState;
}
