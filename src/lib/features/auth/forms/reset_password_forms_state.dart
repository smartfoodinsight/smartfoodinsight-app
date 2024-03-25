import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smartfoodinsight_app/common/validations/validations.dart';

part 'reset_password_forms_state.freezed.dart';

@freezed
class ResetPassowrdFormsState with _$ResetPassowrdFormsState {
  const factory ResetPassowrdFormsState({
    @Default(EmailFormz.pure()) EmailFormz email,
    @Default(false) bool isLoading,
    @Default(false) bool isFormPosted,
    @Default(false) bool isValid,
  }) = _ResetPassowrdFormsState;
}
