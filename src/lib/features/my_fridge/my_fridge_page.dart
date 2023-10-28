import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:smartfoodinsight_app/common/extensions/extensions.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';
import 'package:smartfoodinsight_app/models/models.dart';

class MyFridgePage extends StatelessWidget {
  const MyFridgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          );
        });
  }
}

class _ShowProducts extends ConsumerWidget {
  const _ShowProducts();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsFridge = ref.watch(myFridgeNotifierProvider);

    return productsFridge.when(
        data: (productsFridge) {
          if (productsFridge.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Text(context.loc.myFridgeProducts),
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
        loading: () => const Center(child: CircularProgressIndicator()));
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
    final snackBarUtil = ref.read(snackbarUtilProvider);

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
        snackBarUtil.showActionMessage(
            context.loc.deletedProduct,
            context.loc.undo,
            () => myFridgeNotifier.toggleProductFridgeAsync(productFridge));
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
                subtitle: Text(productFridge.date!),
                leading: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      child: _selectImage(productFridge.image!)),
                ))),
      ),
    );
  }

  Widget _selectImage(String image) {
    if (image.startsWith('http')) {
      return Image.network(productFridge.image!, fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress != null) {
          return const Center(
              child: SizedBox(
                  height: 35, width: 35, child: CircularProgressIndicator()));
        }
        return child;
      });
    }

    return Image.file(File(image));
  }
}
