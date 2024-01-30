import 'package:formz/formz.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';

enum EmailError { empty, format }

class EmailFormz extends FormzInput<String, EmailError> {
  static final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  const EmailFormz.pure() : super.pure('');
  const EmailFormz.dirty(super.value) : super.dirty();

  String? errorMessage(AppLocalizations loc) {
    if (isValid || isPure) return null;

    if (displayError == EmailError.empty) {
      return loc.fieldIsEmpty;
    }
    if (displayError == EmailError.format) {
      return loc.emailIsNotValid;
    }

    return null;
  }

  @override
  EmailError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return EmailError.empty;
    if (!emailRegExp.hasMatch(value)) return EmailError.format;

    return null;
  }
}
