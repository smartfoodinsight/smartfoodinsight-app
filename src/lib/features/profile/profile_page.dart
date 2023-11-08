import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:smartfoodinsight_app/common/widgets/widgets.dart';
import 'package:smartfoodinsight_app/common/extensions/extensions.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifer = ref.read(authNotifierProvider.notifier);
    final cameraGalleryService = ref.read(cameraGalleryServiceProvider);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  GestureDetector(
                    child: const CircleAvatar(
                      radius: 70,
                      backgroundImage:
                          AssetImage('assets/images/foodwaste.png'),
                      child: Stack(children: [
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
                    onTap: () => {
                      showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ListTile(
                                        title: Text(context.loc.camera),
                                        leading:
                                            const Icon(Icons.camera_alt_sharp),
                                        onTap: () async {
                                          context.pop();
                                          final imagePath =
                                              await cameraGalleryService
                                                  .takePhotoAsync();
                                          if (imagePath == null) return;
                                        }),
                                    ListTile(
                                        title: Text(context.loc.gallery),
                                        leading: const Icon(Icons.image),
                                        onTap: () async {
                                          context.pop();
                                          final imagePath =
                                              await cameraGalleryService
                                                  .selectPhotoAsync();
                                          if (imagePath == null) return;
                                        }),
                                  ],
                                ),
                              ),
                            );
                          })
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
      ),
    );
  }
}
