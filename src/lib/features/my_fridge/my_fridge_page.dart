import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:smartfoodinsight_app/common/extensions/extensions.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';

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
    return const Placeholder();
    // final productsAsync = ref.watch(productsNotifierProvider);

    // return productsAsync.when(
    //     data: (products) {
    //       if (products.isEmpty) {
    //         return Padding(
    //           padding: const EdgeInsets.all(16),
    //           child: Text(context.loc.myFridgeProducts),
    //         );
    //       } else {
    //         return ListView.builder(
    //             itemCount: products.length,
    //             itemBuilder: (context, index) {
    //               final product = products[index];
    //               return CustomCard(product: product);
    //             });
    //       }
    //     },
    //     error: (error, stackTrace) => const Text('error'),
    //     loading: () => const Center(child: CircularProgressIndicator()));
  }
}
