import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smartfoodinsight_app/common/validations/validations.dart';

part 'login_page_state.freezed.dart';

@freezed
class LoginPageState with _$LoginPageState {
  const factory LoginPageState({
    @Default(EmailFormz.pure()) EmailFormz email,
    @Default(PasswordFormz.pure()) PasswordFormz password,
    @Default(false) bool isFormPosted,
    @Default(false) bool isValid,
  }) = _LoginPageState;
}
