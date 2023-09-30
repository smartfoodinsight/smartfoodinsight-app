import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:smartfoodinsight_app/common/validations/validations.dart';
import 'package:smartfoodinsight_app/features/account/login/login_page_state.dart';

final loginPageNotifierProvider =
    StateNotifierProvider<LoginPageNotifier, LoginPageState>(
        (ref) => LoginPageNotifier());

class LoginPageNotifier extends StateNotifier<LoginPageState> {
  LoginPageNotifier() : super(const LoginPageState());

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

    // await loginUserCallback(state.email.value, state.password.value);
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
