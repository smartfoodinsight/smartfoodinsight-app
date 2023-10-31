import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';

export 'package:hexcolor/hexcolor.dart';
export 'package:flutter_gen/gen_l10n/app_localizations.dart';
export "package:smartfoodinsight_app/common/utils/app_settings.dart";

class Helper {
  ExpirationResult calculateExpiration(
      String expirationDate, AppLocalizations loc) {
    int daysRemaining = _calculateDaysRemaining(expirationDate);

    if (daysRemaining == 0) {
      return ExpirationResult(loc.expiresToday, Colors.orange);
    } else if (daysRemaining == 1) {
      return ExpirationResult(loc.expiresDay, Colors.orange);
    } else if (daysRemaining < 0) {
      return ExpirationResult(loc.expired, Colors.red);
    } else if (daysRemaining <= 4) {
      return ExpirationResult(
          '${loc.expiresIn} $daysRemaining ${loc.days}', Colors.orange);
    } else if (daysRemaining <= 30) {
      return ExpirationResult(
          '${loc.expiresIn} $daysRemaining ${loc.days}', Colors.green);
    } else {
      int monthsRemaining = _calculateMonthsRemaining(expirationDate);
      if (monthsRemaining == 1) {
        return ExpirationResult(loc.expiresMonth, Colors.green);
      } else if (monthsRemaining > 1) {
        return ExpirationResult(
            '${loc.expiresIn} $monthsRemaining ${loc.months}', Colors.green);
      } else {
        int yearsRemaining = _calculateYearsRemaining(expirationDate);
        if (yearsRemaining == 1) {
          return ExpirationResult(loc.expiresYear, Colors.green);
        } else {
          return ExpirationResult(
              '${loc.expiresIn} $yearsRemaining ${loc.years}', Colors.green);
        }
      }
    }
  }

  int _calculateDaysRemaining(String expirationDate) {
    DateTime currentDate = DateTime.now();
    currentDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    DateFormat format = DateFormat('dd/MM/yyyy');
    DateTime expirationDateParsed = format.parse(expirationDate);
    Duration difference = expirationDateParsed.difference(currentDate);
    return difference.inDays;
  }

  int _calculateMonthsRemaining(String expirationDate) {
    DateTime currentDate = DateTime.now();
    DateFormat format = DateFormat('dd/MM/yyyy');
    DateTime expirationDateParsed = format.parse(expirationDate);
    int monthsRemaining = (expirationDateParsed.year - currentDate.year) * 12 +
        (expirationDateParsed.month - currentDate.month);
    return monthsRemaining;
  }

  int _calculateYearsRemaining(String expirationDate) {
    DateTime currentDate = DateTime.now();
    DateFormat format = DateFormat('dd/MM/yyyy');
    DateTime expirationDateParsed = format.parse(expirationDate);
    int yearsRemaining = expirationDateParsed.year - currentDate.year;
    return yearsRemaining;
  }
}

class ExpirationResult {
  final String message;
  final Color color;

  ExpirationResult(this.message, this.color);
}
