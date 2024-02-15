import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';

import 'package:smartfoodinsight_app/common/widgets/widgets.dart';
import 'package:smartfoodinsight_app/common/extensions/extensions.dart';
import 'package:smartfoodinsight_app/features/profile/profile_page_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileFormsState = ref.watch(profilePageNotifierProvider);
    final profilePageNotifier = ref.read(profilePageNotifierProvider.notifier);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    return profileFormsState.when(
        data: (profileFormsState) {
          final id = profileFormsState.id;
          final name = profileFormsState.name;
          final email = profileFormsState.email;
          final picture = profileFormsState.picture;

          return Scaffold(
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
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
                                        color: Colors
                                            .black) // change this children
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
                          label: context.loc.name,
                          textInputType: TextInputType.name,
                          onChanged: profilePageNotifier.onNameChanged,
                          errorMessage:
                              profileFormsState.name.errorMessage(context.loc),
                          icon: Icons.person),
                      NormalTextFormField(
                          initValue: email.value,
                          label: context.loc.email,
                          readOnly: true,
                          textInputType: TextInputType.emailAddress,
                          onChanged: profilePageNotifier.onEmailChanged,
                          icon: Icons.email),
                      const SizedBox(height: 16),
                      GeneralElevatedButton(
                          onPressed: () => profilePageNotifier.onFormSubmit(id),
                          child: Text(context.loc.save)),
                      const SizedBox(height: 16),
                      const Divider(),
                      ListTile(
                          title: Text(context.loc.deleteAccount),
                          leading: const Icon(Icons.warning),
                          onTap: () {}),
                      ListTile(
                          title: Text(context.loc.logout),
                          leading: const Icon(Icons.logout),
                          onTap: () async {
                            await authNotifier.logoutAsync();
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        error: (error, stackTrace) => const Scaffold(
              body: Center(child: Text('Error')),
            ),
        loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
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
