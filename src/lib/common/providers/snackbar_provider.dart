import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';

class SnackbarUtil {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  SnackbarUtil(this.scaffoldMessengerKey);

  void showActionMessage(String message, String label, VoidCallback onPressed) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: label,
        onPressed: onPressed,
      ),
    ));
  }

  void showSuccessMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.green));
  }

  void showErrorMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text(message), backgroundColor: HexColor("#DF4A32")));
  }
}

final scaffoldMessengerProvider =
    Provider((ref) => GlobalKey<ScaffoldMessengerState>());

final snackbarUtilProvider = Provider<SnackbarUtil>((ref) {
  return SnackbarUtil(ref.watch(scaffoldMessengerProvider));
});
