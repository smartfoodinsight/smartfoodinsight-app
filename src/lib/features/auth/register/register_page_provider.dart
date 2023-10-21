import 'package:formz/formz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/validations/validations.dart';
import 'package:smartfoodinsight_app/features/auth/forms/auth_forms_state.dart';
import 'package:smartfoodinsight_app/services/api/dto/dto.dart';

part 'register_page_provider.g.dart';

@riverpod
class RegisterPageNotifier extends _$RegisterPageNotifier {
  @override
  AuthFormsState build() {
    return const AuthFormsState();
  }

  void onNameChanged(String value) {
    final name = TextFormz.dirty(value);
    state = state.copyWith(name: name, isValid: Formz.validate([name]));
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

    var reqgistrRequest = RegisterRequest(
        name: state.name.value,
        email: state.email.value,
        password: state.password.value);

    final authNotifier = ref.read(authNotifierProvider.notifier);
    await authNotifier.registerAsync(reqgistrRequest);
  }

  void _touchEveryField() {
    final name = TextFormz.dirty(state.name.value);
    final email = EmailFormz.dirty(state.email.value);
    final password = PasswordFormz.dirty(state.password.value);

    state = state.copyWith(
        isFormPosted: true,
        name: name,
        email: email,
        password: password,
        isValid: Formz.validate([name, email, password]));
  }
}
