import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';

class AddProductMyFridgePage extends ConsumerWidget {
  final String ean;
  const AddProductMyFridgePage({required this.ean, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productInfoProvider(ean));

    return productAsync.when(
        data: (product) => Scaffold(),
        error: (error, stackTrace) => Scaffold(
              appBar: AppBar(),
              body: const Center(child: Text('Error')),
            ),
        loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ));
  }
}
