import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';
import 'package:smartfoodinsight_app/common/widgets/widgets.dart';
import 'package:smartfoodinsight_app/common/extensions/extensions.dart';
import 'package:smartfoodinsight_app/features/auth/exceptions/auth_exceptions.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    double bottomPadding = MediaQuery.paddingOf(context).bottom;

    double imageHeight = height * 0.35;
    double sizedBoxHeight = height - imageHeight - bottomPadding;

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
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: _FormLogin(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _FormLogin extends ConsumerWidget {
  const _FormLogin();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginPageState = ref.watch(loginPageNotifierProvider);
    final email = loginPageState.email;
    final password = loginPageState.password;
    final isFormPosted = loginPageState.isFormPosted;
    final loginPageNotifier = ref.read(loginPageNotifierProvider.notifier);
    final loc = ref.read(appLocalizationsProvider);

    ref.listen(authNotifierProvider, (previous, next) {
      if (!next.isLoading && next.hasError) {
        if (next.error is WrongCredentials) {
          final snackBarUtil = ref.read(snackbarUtilProvider);
          snackBarUtil.showErrorMessage(loc.loginError);
        }
      }
    });

    final authState = ref.watch(authNotifierProvider);

    return Column(children: [
      NormalTextFormField(
        label: loc.email,
        icon: Icons.email,
        textInputType: TextInputType.emailAddress,
        onChanged: loginPageNotifier.onEmailChanged,
        errorMessage: isFormPosted ? email.errorMessage(loc) : null,
      ),
      PasswordTextFormField(
          label: loc.password,
          onChanged: loginPageNotifier.onPasswordChanged,
          errorMessage: isFormPosted ? password.errorMessage(loc) : null),
      const _ForgotPasswordButton(),
      const SizedBox(height: 16),
      GeneralElevatedButton(
          onPressed: authState.isLoading
              ? null
              : () => loginPageNotifier.onFormSubmit(),
          child: authState.isLoading
              ? const CircularProgressIndicator()
              : Text(loc.login)),
      const SizedBox(height: 16),
      const _DivederOr(),
      const _SocialButtons(),
      const Spacer(),
      const _SignUpQuestion(),
      const SizedBox(height: 16)
    ]);
  }
}

class _SignUpQuestion extends ConsumerWidget {
  const _SignUpQuestion();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.loc.dontAccount,
          style: const TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
            child: Text(
              context.loc.signup,
              style: const TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onTap: () {
              ref.invalidate(loginPageNotifierProvider);
              context.push(AppSettings.signup);
            }),
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
          context.loc.forgotPassowrd,
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
          padding: MediaQuery.of(context).viewInsets,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: SingleChildScrollView(
                child: _ResetPassword(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ResetPassword extends ConsumerWidget {
  const _ResetPassword();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resetPasswordFormsState = ref.watch(resetPasswordNotifierProvider);

    final email = resetPasswordFormsState.email;
    final isFormPosted = resetPasswordFormsState.isFormPosted;
    final isLoading = resetPasswordFormsState.isLoading;

    final resetPasswordNotifier =
        ref.read(resetPasswordNotifierProvider.notifier);
    final loc = ref.read(appLocalizationsProvider);

    return Column(
      children: [
        Text(context.loc.passwordEmail),
        const SizedBox(height: 16),
        NormalTextFormField(
            label: context.loc.email,
            icon: Icons.email,
            textInputType: TextInputType.emailAddress,
            onChanged: resetPasswordNotifier.onEmailChanged,
            errorMessage: isFormPosted ? email.errorMessage(loc) : null),
        const SizedBox(height: 16),
        GeneralElevatedButton(
            onPressed: isLoading
                ? null
                : () async {
                    final result =
                        await resetPasswordNotifier.onFormSubmitAsync();

                    if (context.mounted && result) {
                      ref
                          .read(snackbarUtilProvider)
                          .showSuccessMessage(loc.registerSucess);
                      context.pop();
                    }
                  },
            child: isLoading
                ? const CircularProgressIndicator()
                : Text(context.loc.send)),
      ],
    );
  }
}

class _SocialButtons extends ConsumerWidget {
  const _SocialButtons();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    return Platform.isAndroid
        ? authState.isLoading
            ? const SizedBox()
            : ElevatedButton(
                onPressed: () => authNotifier.loginGoogleAsync(),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: HexColor("#DF4A32"),
                  padding: const EdgeInsets.all(15),
                ),
                child: const Icon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                ))
        : ElevatedButton(
            onPressed: () => {},
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: Colors.black,
              padding: const EdgeInsets.all(15),
            ),
            child: const Icon(
              FontAwesomeIcons.apple,
              color: Colors.white,
            ));
  }
}

class _DivederOr extends StatelessWidget {
  const _DivederOr();

  @override
  Widget build(BuildContext context) {
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
}
