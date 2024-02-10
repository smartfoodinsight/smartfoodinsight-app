import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smartfoodinsight_app/common/widgets/widgets.dart';
import 'package:smartfoodinsight_app/common/extensions/extensions.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifer = ref.read(authNotifierProvider.notifier);

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
                    backgroundImage: _selectImage(null),
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
                    if (imagePath != null) {}
                  },
                ),
                const SizedBox(height: 16),
                NormalTextFormField(
                    initValue: 'Pepito Perez',
                    label: context.loc.name,
                    textInputType: TextInputType.name,
                    icon: Icons.person),
                NormalTextFormField(
                    initValue: 'Pepito@gmail.com',
                    label: context.loc.email,
                    readOnly: true,
                    textInputType: TextInputType.emailAddress,
                    icon: Icons.email),
                const SizedBox(height: 16),
                GeneralElevatedButton(
                    onPressed: null, child: Text(context.loc.save)),
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
                      await authNotifer.logoutAsync();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

ImageProvider<Object> _selectImage(String? image) {
  return image != null
      ? image.startsWith('http')
          ? NetworkImage(image) as ImageProvider
          : FileImage(File(image))
      : const AssetImage('assets/images/foodwaste.png');
}
