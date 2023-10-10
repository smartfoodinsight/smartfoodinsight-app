import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:smartfoodinsight_app/common/extensions/extensions.dart';

enum TextError { empty }

class TextFormz extends FormzInput<String, TextError> {
  const TextFormz.pure() : super.pure('');
  const TextFormz.dirty(String value) : super.dirty(value);

  String? errorMessage(BuildContext context) {
    if (isValid || isPure) return null;

    if (displayError == TextError.empty) {
      return context.loc.fieldIsEmpty;
    }

    return null;
  }

  @override
  TextError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return TextError.empty;
    return null;
  }
}
