import 'package:formz/formz.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';

enum TextError { empty }

class TextFormz extends FormzInput<String, TextError> {
  const TextFormz.pure() : super.pure('');
  const TextFormz.dirty(String value) : super.dirty(value);

  String? errorMessage(AppLocalizations loc) {
    if (isValid || isPure) return null;

    if (displayError == TextError.empty) {
      return loc.fieldIsEmpty;
    }

    return null;
  }

  @override
  TextError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return TextError.empty;
    return null;
  }
}
