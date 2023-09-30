import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:smartfoodinsight_app/extensions/app_localizations_extension.dart';

enum EmailError { empty, format }

class EmailFormz extends FormzInput<String, EmailError> {
  static final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  const EmailFormz.pure() : super.pure('');
  const EmailFormz.dirty(String value) : super.dirty(value);

  String? errorMessage(BuildContext context) {
    if (isValid || isPure) return null;

    if (displayError == EmailError.empty) {
      return context.loc.fieldIsEmpty;
    }
    if (displayError == EmailError.format) {
      return context.loc.emailIsNotValid;
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
