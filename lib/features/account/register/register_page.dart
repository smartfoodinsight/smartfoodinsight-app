import 'package:flutter/material.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';
import 'package:smartfoodinsight_app/common/widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height * 0.35;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: HexColor("#aac6f9"),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/fooddelivery.png',
                  fit: BoxFit.fill, height: height, width: width),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      NormalTextFormField(
                          label: AppLocalizations.of(context)!.name,
                          icon: const Icon(Icons.person)),
                      NormalTextFormField(
                          label: AppLocalizations.of(context)!.email,
                          icon: const Icon(Icons.email)),
                      PasswordTextFormField(
                          label: AppLocalizations.of(context)!.password),
                      const SizedBox(height: 16),
                      GeneralElevatedButton(
                          onPressed: () => null,
                          child: Text(AppLocalizations.of(context)!.signup)),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
