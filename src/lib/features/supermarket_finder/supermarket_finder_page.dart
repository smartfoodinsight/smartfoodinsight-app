import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';
import 'package:smartfoodinsight_app/features/supermarket_finder/supermarket_finder_page_provider.dart';
import 'package:smartfoodinsight_app/services/api/dto/dto.dart';

class SuperMarketFinderPage extends StatelessWidget {
  const SuperMarketFinderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(children: [
              _SearchBar(),
              SizedBox(height: 16),
              _SupermarketProducts(),
            ])));
  }
}

class _SupermarketProducts extends ConsumerWidget {
  const _SupermarketProducts();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marketsAsync = ref.watch(superMarketFinderNotifierProvider);
    return marketsAsync.when(
        data: (superMarkets) {
          if (superMarkets.isEmpty) {
            return const Placeholder();
          } else {
            return Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    mainAxisExtent: 280,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: superMarkets.length,
                  itemBuilder: (context, index) {
                    final product = superMarkets[index];
                    return _CustomProduct(product);
                  }),
            );
          }
        },
        error: (error, stackTrace) => const Text('error'),
        loading: () => const CircularProgressIndicator());
  }
}

class _CustomProduct extends ConsumerWidget {
  final SupermarketProductResponse product;
  const _CustomProduct(this.product);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async => {
        await context.push('${AppSettings.productDetails}${product.ean13}'),
      },
      child: SizedBox(
        width: 300,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                child: Image.network(
                  product.image,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.market,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.price,
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends ConsumerStatefulWidget {
  const _SearchBar();

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends ConsumerState<_SearchBar> {
  final textEditingController = TextEditingController();
  bool showClearButton = false;

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(() {
      setState(() {
        showClearButton = textEditingController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
        controller: textEditingController,
        onSubmitted: (value) => ref
            .read(superMarketFinderNotifierProvider.notifier)
            .superMarketFinderAsync([1], value),
        leading: const Icon(Icons.search),
        trailing: [
          IconButton(
              icon: const Icon(Icons.shopping_bag),
              onPressed: () async {
                textEditingController.clear();
                await ref
                    .read(superMarketFinderNotifierProvider.notifier)
                    .clearAsync();
              }),
          if (showClearButton)
            IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () async {
                  textEditingController.clear();
                  await ref
                      .read(superMarketFinderNotifierProvider.notifier)
                      .clearAsync();
                }),
        ]);
  }
}
