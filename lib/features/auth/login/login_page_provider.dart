import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:formz/formz.dart';
import 'package:smartfoodinsight_app/common/validations/validations.dart';
import 'package:smartfoodinsight_app/features/auth/auth_provider.dart';
import 'package:smartfoodinsight_app/features/auth/login/login_page_state.dart';
import 'package:smartfoodinsight_app/services/api/dto/dto.dart';

part 'login_page_provider.g.dart';

@riverpod
class LoginPageNotifier extends _$LoginPageNotifier {
  @override
  LoginPageState build() {
    return const LoginPageState();
  }

  bool validate({EmailFormz? email, PasswordFormz? password}) {
    return Formz.validate([email ?? state.email, password ?? state.password]);
  }

  void onEmailChange(String value) {
    final email = EmailFormz.dirty(value);
    state = state.copyWith(email: email, isValid: validate(email: email));
  }

  void onPasswordChanged(String value) {
    final password = PasswordFormz.dirty(value);
    state = state.copyWith(
        password: password, isValid: validate(password: password));
  }

  void onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    var loginRequest =
        LoginRequest(email: state.email.value, password: state.password.value);
    final authNotifier = ref.read(authNotifierProvider.notifier);
    await authNotifier.loginAsync(loginRequest);
  }

  _touchEveryField() {
    final email = EmailFormz.dirty(state.email.value);
    final password = PasswordFormz.dirty(state.password.value);

    state = state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        isValid: validate(email: email, password: password));
  }
}
