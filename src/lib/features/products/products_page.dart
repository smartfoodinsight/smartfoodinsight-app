import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:smartfoodinsight_app/common/extensions/extensions.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';
import 'package:smartfoodinsight_app/models/models.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const _ShowProducts(),
        floatingActionButton: ElevatedButton(
          onPressed: () => context.push(AppSettings.scan),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: HexColor("#aac6f9"),
            padding: const EdgeInsets.all(15),
          ),
          child: SvgPicture.asset(
            'assets/images/sb.svg',
            width: 32.0,
            height: 32.0,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
        ));
  }
}

class _ShowProducts extends ConsumerWidget {
  const _ShowProducts();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsNotifierProvider);

    return productsAsync.when(
        data: (products) {
          if (products.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Text(context.loc.productsEmpty),
            );
          } else {
            return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return CustomCard(product: product);
                });
          }
        },
        error: (error, stackTrace) => const Text('error'),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}

class CustomCard extends ConsumerWidget {
  const CustomCard({
    super.key,
    required this.product,
  });

  final ProductDetail product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsNotifier = ref.read(productsNotifierProvider.notifier);
    final snackBarUtil = ref.read(snackbarUtilProvider);

    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.redAccent,
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Icon(
            FontAwesomeIcons.trash,
            color: Colors.white,
          ),
        ),
      ),
      onDismissed: (direction) {
        productsNotifier.toggleProductAsync(product);
        snackBarUtil.showActionMessage(
            context.loc.deletedProduct,
            context.loc.undo,
            () => productsNotifier.toggleProductAsync(product));
      },
      key: UniqueKey(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 1,
            child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    child: Image.network(
                      product.imageFrontUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(product.name))),
      ),
    );
  }
}
