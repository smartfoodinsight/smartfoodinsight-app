import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smartfoodinsight_app/common/utils/utis.dart';

extension AsyncValueUI on AsyncValue {
  void showSnackbarError(BuildContext context, String message) {
    if (!isLoading && hasError) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message), backgroundColor: HexColor("#DF4A32")));
    }
  }
}
