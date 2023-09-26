import 'package:flutter/material.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';

class GeneralElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;

  const GeneralElevatedButton(
      {super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(200, 45),
          backgroundColor: HexColor("#faa28b"),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.w900)),
      onPressed: onPressed,
      child: child,
    );
  }
}
