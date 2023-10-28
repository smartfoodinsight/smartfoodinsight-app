import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smartfoodinsight_app/common/extensions/extensions.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/widgets/widgets.dart';

class AddProductMyFridgePage extends ConsumerWidget {
  final String ean;
  const AddProductMyFridgePage({required this.ean, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(myFridgeNotifierProvider(ean));
    final myFridgeNotifier = ref.read(myFridgeNotifierProvider(ean).notifier);
    final cameraGalleryService = ref.read(cameraGalleryServiceProvider);

    return productAsync.when(
        data: (product) {
          return Scaffold(
              appBar: AppBar(actions: [
                IconButton(onPressed: () => {}, icon: const Icon(Icons.save_as))
              ]),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  GestureDetector(
                    child: _selectImage(product.image),
                    onTap: () {
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
                                          myFridgeNotifier
                                              .updateImage(imagePath);
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
                                          myFridgeNotifier
                                              .updateImage(imagePath);
                                        }),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                  NormalTextFormField(
                      initValue: product.name,
                      label: context.loc.name,
                      onChanged: myFridgeNotifier.onNameChanged,
                      icon: Icons.edit_document),
                  const SizedBox(height: 16),
                  DateTextFormField(
                    onChanged: myFridgeNotifier.onDateChanged,
                    label: context.loc.useByDate,
                  )
                ]),
              ));
        },
        error: (error, stackTrace) => Scaffold(
              appBar: AppBar(),
              body: const Center(child: Text('Error')),
            ),
        loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ));
  }
}

Widget _selectImage(String? image) {
  double height = 140;
  return image != null
      ? image.startsWith('http')
          ? Image.network(image, fit: BoxFit.cover, height: height)
          : Image.file(File(image), fit: BoxFit.cover, height: height)
      : const Icon(Icons.image_search, size: 100, color: Colors.black);
}
