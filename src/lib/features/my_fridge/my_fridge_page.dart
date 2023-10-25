import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:smartfoodinsight_app/common/extensions/extensions.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';
import 'package:smartfoodinsight_app/common/widgets/widgets.dart';

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
                height: 250,
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  child: Column(
                    children: [
                      GeneralFilledIconButton(
                          label: Text(context.loc.scanProduct),
                          onPressed: () => context.push(AppSettings.scanfridge),
                          icon: const Icon(Icons.search))
                    ],
                  ),
                )),
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
