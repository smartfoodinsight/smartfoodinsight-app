import 'package:flutter/material.dart';

import 'package:smartfoodinsight_app/common/utils/utis.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
}
