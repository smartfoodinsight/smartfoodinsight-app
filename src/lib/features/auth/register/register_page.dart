import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';
import 'package:smartfoodinsight_app/common/widgets/widgets.dart';
import 'package:smartfoodinsight_app/common/extensions/extensions.dart';
import 'package:smartfoodinsight_app/features/auth/auth_state.dart';
import 'package:smartfoodinsight_app/features/auth/exceptions/auth_exceptions.dart';

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
              const Padding(padding: EdgeInsets.all(16), child: _FormRegister())
            ],
          ),
        ),
      ),
    );
  }
}

class _FormRegister extends ConsumerWidget {
  const _FormRegister();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authFormsState = ref.watch(registerPageNotifierProvider);
    final name = authFormsState.name;
    final email = authFormsState.email;
    final password = authFormsState.password;
    final isFormPosted = authFormsState.isFormPosted;

    final loc = ref.read(appLocalizationsProvider);

    final registerPageNotifier =
        ref.read(registerPageNotifierProvider.notifier);

    ref.listen(authNotifierProvider, (previous, next) {
      final snackBarUtil = ref.read(snackbarUtilProvider);
      next.when(
          data: (data) {
            if (data.authStatus == AuthStatus.registrated) {
              snackBarUtil.showSuccessMessage(loc.registerSucess);
              context.pop();
            }
          },
          error: (error, stackTrace) {
            if (!next.isLoading && next.hasError) {
              if (next.error is WrongRegistration) {
                snackBarUtil.showErrorMessage(loc.registerError);
              }
            }
          },
          loading: () {});
    });

    final authSate = ref.watch(authNotifierProvider);

    return Column(
      children: [
        NormalTextFormField(
            label: context.loc.name,
            textInputType: TextInputType.name,
            icon: const Icon(Icons.person),
            onChanged: registerPageNotifier.onNameChanged,
            errorMessage: isFormPosted ? name.errorMessage(loc) : null),
        NormalTextFormField(
            label: context.loc.email,
            textInputType: TextInputType.emailAddress,
            icon: const Icon(Icons.email),
            onChanged: registerPageNotifier.onEmailChanged,
            errorMessage: isFormPosted ? email.errorMessage(loc) : null),
        PasswordTextFormField(
            label: context.loc.password,
            onChanged: registerPageNotifier.onPasswordChanged,
            errorMessage: isFormPosted ? password.errorMessage(loc) : null),
        const SizedBox(height: 16),
        GeneralElevatedButton(
            onPressed: authSate.isLoading
                ? null
                : () => registerPageNotifier.onFormSubmit(),
            child: authSate.isLoading
                ? const CircularProgressIndicator()
                : Text(context.loc.signup))
      ],
    );
  }
}
