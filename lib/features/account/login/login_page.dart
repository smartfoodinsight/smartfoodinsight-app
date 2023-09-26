import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';
import 'package:smartfoodinsight_app/common/widgets/widgets.dart';
import 'package:smartfoodinsight_app/router/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    double imageHeight = height * 0.35;
    double sizedBoxHeight = height - imageHeight;
    //double paddingTop = height - MediaQuery.viewPaddingOf(context).top;

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
            children: [
              Image.asset('assets/images/fooddelivery.png',
                  fit: BoxFit.fill, height: imageHeight, width: width),
              SizedBox(
                height: sizedBoxHeight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    NormalTextFormField(
                        label: AppLocalizations.of(context)!.email,
                        icon: const Icon(Icons.email)),
                    PasswordTextFormField(
                        label: AppLocalizations.of(context)!.password),
                    const _ForgotPasswordButton(),
                    const SizedBox(height: 16),
                    GeneralElevatedButton(
                        onPressed: () => null,
                        child: Text(AppLocalizations.of(context)!.login)),
                    const SizedBox(height: 16),
                    _dividerOr(),
                    const _SocialButtons(),
                    const Spacer(),
                    const _SignUpQuestion(),
                    const SizedBox(height: 16)
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpQuestion extends StatelessWidget {
  const _SignUpQuestion();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.dontAccount,
          style: const TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          child: Text(
            AppLocalizations.of(context)!.signup,
            style: const TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onTap: () => context.push(Routes.signup),
        ),
      ],
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text(
          AppLocalizations.of(context)!.forgotPassowrd,
          style: const TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        onPressed: () => _showBottomSheet(context),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.viewInsetsOf(context),
            child: SizedBox(
                height: 250,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  child: Column(
                    children: [
                      Text(AppLocalizations.of(context)!.passwordEmail),
                      const SizedBox(height: 16),
                      NormalTextFormField(
                          label: AppLocalizations.of(context)!.email,
                          icon: const Icon(Icons.email)),
                      const SizedBox(height: 16),
                      GeneralElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(AppLocalizations.of(context)!.send))
                    ],
                  ),
                )),
          );
        });
  }
}

class _SocialButtons extends StatelessWidget {
  const _SocialButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => {},
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: Colors.black,
            padding: const EdgeInsets.all(15),
          ),
          child: const Icon(
            FontAwesomeIcons.apple,
            color: Colors.white,
          ),
        ),
        ElevatedButton(
          onPressed: () => {},
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: HexColor("#DF4A32"),
            padding: const EdgeInsets.all(15),
          ),
          child: const Icon(
            FontAwesomeIcons.google,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

Widget _dividerOr() {
  return Row(children: [
    Expanded(
      child: Container(
          margin: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: const Divider(
            color: Colors.black,
            height: 36,
          )),
    ),
    const Text("O"),
    Expanded(
      child: Container(
          margin: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: const Divider(
            color: Colors.black,
            height: 36,
          )),
    ),
  ]);
}
