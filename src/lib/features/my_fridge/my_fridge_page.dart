import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:smartfoodinsight_app/common/extensions/extensions.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';
import 'package:smartfoodinsight_app/common/widgets/widgets.dart';
import 'package:smartfoodinsight_app/models/models.dart';
import 'package:smartfoodinsight_app/services/services.dart';

class MyFridgePage extends StatelessWidget {
  const MyFridgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*         appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => {}, icon: const Icon(Icons.notifications))
          ],
        ), */
        body: const _ShowProducts(),
        floatingActionButton: ElevatedButton(
            onPressed: () => _showBottomSheet(context),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: HexColor("#aac6f9"),
              padding: const EdgeInsets.all(15),
            ),
            child: const Icon(Icons.add, size: 32, color: Colors.black)));
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.viewInsetsOf(context),
            child: SafeArea(
              bottom: true,
              child: SizedBox(
                height: 150,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                        title: Text(context.loc.scanProduct),
                        leading: const Icon(FontAwesomeIcons.barcode),
                        onTap: () => {
                              context.push(AppSettings.scanfridge),
                              context.pop()
                            }),
                    ListTile(
                        title: Text(context.loc.addProductManually),
                        leading: const Icon(Icons.edit_document),
                        onTap: () => {
                              context
                                  .push('${AppSettings.addProductMyFridge}new'),
                              context.pop(),
                            }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class _ShowProducts extends ConsumerWidget {
  const _ShowProducts();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsFridge = ref.watch(myFridgeNotifierProvider);
    final loc = ref.read(appLocalizationsProvider);

    return productsFridge.when(
        data: (productsFridge) {
          if (productsFridge.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 10, left: 40, right: 40),
              child: Column(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image.asset('assets/images/foodwaste.png',
                        gaplessPlayback: true)),
                const SizedBox(height: 16),
                Text(loc.myFridgeProducts,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold))
              ]),
            );
          } else {
            return ListView.builder(
                itemCount: productsFridge.length,
                itemBuilder: (context, index) {
                  final productFridge = productsFridge[index];
                  return _CustomCard(productFridge: productFridge);
                });
          }
        },
        error: (error, stackTrace) => const Text('error'),
        loading: () => const ProductsLoading());
  }
}

class _CustomCard extends ConsumerWidget {
  const _CustomCard({
    required this.productFridge,
  });

  final ProductFridge productFridge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myFridgeNotifier = ref.read(myFridgeNotifierProvider.notifier);
    final loc = ref.read(appLocalizationsProvider);
    final expirationResult =
        Helper().calculateExpiration(productFridge.date!, loc);

    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Icon(
            FontAwesomeIcons.trash,
            color: Colors.white,
          ),
        ),
      ),
      onDismissed: (direction) {
        myFridgeNotifier.toggleProductFridgeAsync(productFridge);
        LocalNotificationsService()
            .cancelNotificationAsync(productFridge.idNotification);
      },
      key: UniqueKey(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 1,
            child: ListTile(
                title: Text(productFridge.name!),
                subtitle: Row(children: [
                  Icon(Icons.watch_later_outlined,
                      color: expirationResult.color),
                  const SizedBox(width: 6),
                  Text(expirationResult.message,
                      style: TextStyle(color: expirationResult.color))
                ]),
                leading: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      child: _selectImage(productFridge.image)),
                ))),
      ),
    );
  }

  Widget _selectImage(String? image) {
    if (image == null) {
      return const Icon(Icons.image, size: 48, color: Colors.black);
    }

    if (image.startsWith('http')) {
      return Image.network(image, fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress != null) {
          return const Center(
              child: SizedBox(
                  height: 35, width: 35, child: CircularProgressIndicator()));
        }
        return child;
      });
    }

    return Image.file(File(image), fit: BoxFit.cover);
  }
}
