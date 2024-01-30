import 'package:formz/formz.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';

enum PasswordError { empty, length, format }

class PasswordFormz extends FormzInput<String, PasswordError> {
  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
  );

  const PasswordFormz.pure() : super.pure('');
  const PasswordFormz.dirty(super.value) : super.dirty();

  String? errorMessage(AppLocalizations loc) {
    if (isValid || isPure) return null;

    if (displayError == PasswordError.empty) return loc.fieldIsEmpty;
    // if (displayError == PasswordError.length) return 'Mínimo 6 caracteres';
    // if (displayError == PasswordError.format)
    //   return 'Debe de tener Mayúscula, letras y un número';

    return null;
  }

  @override
  PasswordError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PasswordError.empty;
    // if (value.length < 6) return PasswordError.length;
    // if (!passwordRegExp.hasMatch(value)) return PasswordError.format;

    return null;
  }
}
