import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';
import 'package:smartfoodinsight_app/common/widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: Container(
                    padding: const EdgeInsets.all(30),
                    child: const _FormsProfile()))));
  }
}

class _FormsProfile extends ConsumerWidget {
  const _FormsProfile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileFormsState = ref.watch(profilePageNotifierProvider);
    final profilePageNotifier = ref.read(profilePageNotifierProvider.notifier);
    final authNotifier = ref.read(authNotifierProvider.notifier);
    final loc = ref.read(appLocalizationsProvider);

    return profileFormsState.when(
        data: (profileFormsState) {
          final id = profileFormsState.id;
          final name = profileFormsState.name;
          final email = profileFormsState.email;
          final picture = profileFormsState.picture;
          final isFormPosted = profileFormsState.isFormPosted;
          final isLoading = profileFormsState.isLoading;

          return Column(
            children: <Widget>[
              ImageSelectionModal(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: _selectImage(picture),
                  child: const Stack(children: [
                    Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.camera_alt,
                                color: Colors.black) // change this children
                            ))
                  ]),
                ),
                onImageSelected: (imagePath) {
                  if (imagePath != null) {
                    profilePageNotifier.onPictureChanged(imagePath);
                  }
                },
              ),
              const SizedBox(height: 16),
              NormalTextFormField(
                  initValue: name.value,
                  label: loc.name,
                  textInputType: TextInputType.name,
                  onChanged: profilePageNotifier.onNameChanged,
                  errorMessage: isFormPosted ? email.errorMessage(loc) : null,
                  icon: Icons.person),
              NormalTextFormField(
                  initValue: email.value,
                  label: loc.email,
                  readOnly: true,
                  textInputType: TextInputType.emailAddress,
                  onChanged: profilePageNotifier.onEmailChanged,
                  icon: Icons.email),
              const SizedBox(height: 16),
              GeneralElevatedButton(
                  onPressed: () =>
                      isLoading ? null : profilePageNotifier.onFormSubmit(id),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : Text(loc.save)),
              const SizedBox(height: 16),
              const Divider(),
              ListTile(
                  title: Text(loc.privacyPolicy),
                  leading: const Icon(Icons.privacy_tip_outlined),
                  onTap: () async {
                    Uri uri = Uri.parse(AppSettings.smartPrivacy);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  }),
              // ListTile(
              //     title: Text(loc.deleteAccount),
              //     leading: const Icon(Icons.warning),
              //     onTap: () {}),
              ListTile(
                  title: Text(loc.logout),
                  leading: const Icon(Icons.logout),
                  onTap: () async {
                    await authNotifier.logoutAsync();
                  }),
            ],
          );
        },
        error: (error, stackTrace) => const Center(
              child: Text('Error'),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}

ImageProvider<Object> _selectImage(String? image) {
  return image != null
      ? image.startsWith('http')
          ? NetworkImage(image) as ImageProvider
          : FileImage(File(image))
      : const AssetImage('assets/images/foodwaste.png');
}
