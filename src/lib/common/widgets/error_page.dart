import 'package:flutter/material.dart';
import 'package:smartfoodinsight_app/common/extensions/app_localizations_extension.dart';
import 'package:smartfoodinsight_app/common/widgets/widgets.dart';

class ErrorPage extends StatelessWidget {
  final VoidCallback? onPressed;

  const ErrorPage({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset('assets/images/tryagain.png', fit: BoxFit.fill),
      const SizedBox(height: 16),
      GeneralElevatedButton(
        onPressed: onPressed,
        child: Text(context.loc.tryagain),
      )
    ]);
  }
}
