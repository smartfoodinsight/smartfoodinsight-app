import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:smartfoodinsight_app/common/extensions/extensions.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';

class ImageSelectionModal extends ConsumerWidget {
  final Widget child;
  final void Function(String?) onImageSelected;

  const ImageSelectionModal({
    super.key,
    required this.child,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraGalleryService = ref.read(cameraGalleryServiceProvider);

    return GestureDetector(
      child: child,
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
                          leading: const Icon(Icons.camera_alt_sharp),
                          onTap: () async {
                            context.pop();
                            final imagePath =
                                await cameraGalleryService.takePhotoAsync();
                            onImageSelected(imagePath);
                          }),
                      ListTile(
                          title: Text(context.loc.gallery),
                          leading: const Icon(Icons.image),
                          onTap: () async {
                            context.pop();
                            final imagePath =
                                await cameraGalleryService.selectPhotoAsync();
                            onImageSelected(imagePath);
                          }),
                    ],
                  ),
                ),
              );
            })
      },
    );
  }
}
