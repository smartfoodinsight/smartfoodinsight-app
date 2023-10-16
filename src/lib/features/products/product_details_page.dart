import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:smartfoodinsight_app/features/products/products_details_page_provider.dart';

class ProductDetailsPage extends ConsumerWidget {
  final String ean;
  const ProductDetailsPage({required this.ean, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productInfoProvider(ean));

    return productAsync.when(
        data: (product) => Scaffold(
              body: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  _CustomSliverAppBar(product: product),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    childCount: 1,
                    (context, index) => _ProductDetails(product: product),
                  ))
                ],
              ),
            ),
        error: (error, stackTrace) => const Text('error'),
        loading: () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ));
  }
}

class _ProductDetails extends StatelessWidget {
  final Product product;

  const _ProductDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: product.imageFrontUrl != null
                      ? Image.network(product.imageFrontUrl!,
                          width: size.width * 0.3, fit: BoxFit.cover)
                      : Image.asset('images/imagenotavailable.png',
                          width: size.width * 0.3, fit: BoxFit.cover),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: (size.width - 40) * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.productName!, style: textStyle.titleLarge),
                    ],
                  ),
                ),
              ],
            ))
      ],
    );
  }
}

class _CustomSliverAppBar extends ConsumerWidget {
  final Product product;

  const _CustomSliverAppBar({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.5,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        background: Stack(children: [
          SizedBox.expand(
              child: product.imageFrontUrl != null
                  ? Image.network(product.imageFrontUrl!, fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) return const SizedBox();
                      return FadeInRight(child: child);
                    })
                  : Image.asset('images/imagenotavailable.png',
                      fit: BoxFit.cover)),
          const _CustomGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.0, 0.2],
            colors: [Colors.black54, Colors.transparent],
          ),
          const _CustomGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.7, 1.0],
            colors: [Colors.transparent, Colors.black87],
          ),
          const _CustomGradient(
            begin: Alignment.topLeft,
            stops: [0.0, 0.4],
            colors: [Colors.black87, Colors.transparent],
          ),
        ]),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient(
      {this.begin = Alignment.centerLeft,
      this.end = Alignment.centerRight,
      required this.stops,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: begin, end: end, stops: stops, colors: colors)),
    ));
  }
}
