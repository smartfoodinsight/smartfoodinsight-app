import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:formz/formz.dart';

import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/validations/validations.dart';
import 'package:smartfoodinsight_app/features/auth/forms/auth_forms_state.dart';
import 'package:smartfoodinsight_app/features/auth/forms/reset_password_forms_state.dart';
import 'package:smartfoodinsight_app/services/api/dto/dto.dart';

part 'login_page_provider.g.dart';

@riverpod
class ResetPasswordNotifier extends _$ResetPasswordNotifier {
  @override
  ResetPassowrdFormsState build() {
    return const ResetPassowrdFormsState();
  }

  void onEmailChanged(String value) {
    final email = EmailFormz.dirty(value);
    state = state.copyWith(email: email, isValid: Formz.validate([email]));
  }

  Future<bool> onFormSubmitAsync() async {
    final email = EmailFormz.dirty(state.email.value);

    state = state.copyWith(
        isFormPosted: true, email: email, isValid: Formz.validate([email]));

    if (!state.isValid) return false;

    state = state.copyWith(isLoading: true);

    var userEmailRequest = UserEmailRequest(email: state.email.value);
    await ref.read(apiServiceProvider).resetPasswordAsync(userEmailRequest);

    state = state.copyWith(isLoading: false);
    return true;
  }
}

@riverpod
class LoginPageNotifier extends _$LoginPageNotifier {
  @override
  AuthFormsState build() {
    return const AuthFormsState();
  }

  void onEmailChanged(String value) {
    final email = EmailFormz.dirty(value);
    state = state.copyWith(email: email, isValid: Formz.validate([email]));
  }

  void onPasswordChanged(String value) {
    final password = PasswordFormz.dirty(value);
    state =
        state.copyWith(password: password, isValid: Formz.validate([password]));
  }

  void onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    var loginRequest =
        LoginRequest(email: state.email.value, password: state.password.value);
    final authNotifier = ref.read(authNotifierProvider.notifier);
    await authNotifier.loginAsync(loginRequest);
  }

  void _touchEveryField() {
    final email = EmailFormz.dirty(state.email.value);
    final password = PasswordFormz.dirty(state.password.value);

    state = state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        isValid: Formz.validate([email, password]));
  }
}
