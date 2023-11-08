import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:smartfoodinsight_app/common/extensions/extensions.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/widgets/widgets.dart';
import 'package:smartfoodinsight_app/services/services.dart';

class AddProductMyFridgePage extends ConsumerWidget {
  final String ean;
  const AddProductMyFridgePage({required this.ean, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productFridgeAsync = ref.watch(addMyFridgeNotifierProvider(ean));
    final addMyFridgeNotifier =
        ref.read(addMyFridgeNotifierProvider(ean).notifier);
    final myFridgeNotifier = ref.read(myFridgeNotifierProvider.notifier);
    final loc = ref.read(appLocalizationsProvider);

    return productFridgeAsync.when(
        data: (productFridge) {
          return Scaffold(
              appBar: AppBar(actions: [
                IconButton(
                    onPressed: () async {
                      await myFridgeNotifier
                          .toggleProductFridgeAsync(productFridge);

                      final dateTime =
                          DateFormat('dd/MM/yyyy').parse(productFridge.date!);

                      await LocalNotificationsService()
                          .scheduleNotificationAsync(
                              id: productFridge.idNotification,
                              title: productFridge.name,
                              body: loc.theProductExpired,
                              dateTime: dateTime)
                          .whenComplete(() => context.pop());
                    },
                    icon: const Icon(Icons.save_as))
              ]),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  ImageSelectionModal(
                    child: _selectImage(productFridge.image),
                    onImageSelected: (imagePath) {
                      if (imagePath != null) {
                        addMyFridgeNotifier.updateImage(imagePath);
                      }
                    },
                  ),
                  NormalTextFormField(
                      initValue: productFridge.name,
                      label: context.loc.name,
                      onChanged: addMyFridgeNotifier.onNameChanged,
                      icon: Icons.edit_document),
                  const SizedBox(height: 16),
                  DateTextFormField(
                    onChanged: addMyFridgeNotifier.onDateChanged,
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
