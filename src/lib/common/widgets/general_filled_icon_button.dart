import 'package:flutter/material.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';

class GeneralFilledIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget label;
  final Widget icon;

  const GeneralFilledIconButton(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
        label: Align(alignment: Alignment.center, child: label),
        onPressed: onPressed,
        icon: icon,
        style: FilledButton.styleFrom(
            fixedSize: const Size(210, 45),
            backgroundColor: HexColor("#FF998C"),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.w900)));
  }
}
