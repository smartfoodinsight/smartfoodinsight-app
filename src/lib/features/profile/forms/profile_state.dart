import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smartfoodinsight_app/common/validations/validations.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileFormsState with _$ProfileFormsState {
  const factory ProfileFormsState({
    required String id,
    @Default(TextFormz.pure()) TextFormz name,
    @Default(EmailFormz.pure()) EmailFormz email,
    String? picture,
    @Default(false) bool isFormPosted,
    @Default(false) bool isValid,
    @Default(false) bool isLoading,
  }) = _ProfileFormsState;
}
