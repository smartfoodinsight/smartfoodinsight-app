import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smartfoodinsight_app/common/extensions/app_localizations_extension.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/widgets/widgets.dart';
import 'package:smartfoodinsight_app/models/models.dart';
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
    final superMarketNotifer =
        ref.read(superMarketFinderNotifierProvider.notifier);
    final superMarketsNotifer =
        ref.read(superMarketsFilterNotifierProvider.notifier);

    return marketsAsync.when(
        data: (superMarkets) {
          if (superMarkets.isEmpty) {
            return Container();
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
        error: (error, stackTrace) => ErrorPage(onPressed: () {
              final term = superMarketsNotifer.selectedTerm();
              final supermarkets = superMarketsNotifer.selectedSupermarkets();
              superMarketNotifer.superMarketFinderAsync(supermarkets, term);
            }),
        loading: () => const ProductsMarketLoading());
  }
}

class _CustomProduct extends StatelessWidget {
  const _CustomProduct(this.product);

  final SupermarketProductResponse product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => {
        // await context.push('${AppSettings.productDetails}${product.ean13}'),
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
    final marketsAsync = ref.watch(supermarketsProvider);
    final superMarketNotifer =
        ref.read(superMarketFinderNotifierProvider.notifier);
    final superMarketsNotifer =
        ref.read(superMarketsFilterNotifierProvider.notifier);

    return marketsAsync.when(
        data: (superMarkets) {
          if (superMarkets.isEmpty) {
            return ErrorPage(
                onPressed: () => ref.invalidate(supermarketsProvider));
          } else {
            return SearchBar(
                controller: textEditingController,
                onSubmitted: (value) {
                  final supermarkets =
                      superMarketsNotifer.selectedSupermarkets();
                  superMarketsNotifer.setTerm(value);
                  superMarketNotifer.superMarketFinderAsync(
                      supermarkets, value);
                },
                leading: const Icon(Icons.search),
                trailing: [
                  IconButton(
                      icon: const Icon(Icons.shopping_bag),
                      onPressed: () {
                        _showMarketsFilter(superMarkets);
                      }),
                  const _SortProductsButton(),
                  if (showClearButton)
                    IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () async {
                          textEditingController.clear();
                          await superMarketNotifer.clearAsync();
                        }),
                ]);
          }
        },
        error: (error, stackTrace) =>
            ErrorPage(onPressed: () => ref.invalidate(supermarketsProvider)),
        loading: () => const CircularProgressIndicator());
  }

  void _showMarketsFilter(List<SupermarketResponse> superMarkets) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.loc.supermarkets),
          content: SingleChildScrollView(
            child: _SupermarketsFilter(superMarkets),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(context.loc.accept),
            ),
          ],
        );
      },
    );
  }
}

class _SortProductsButton extends ConsumerWidget {
  const _SortProductsButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSortProducts = ref.watch(sortProductsNotifierProvider);

    return PopupMenuButton(
        icon: const Icon(Icons.tune),
        initialValue: selectedSortProducts,
        onSelected: (sortProducts) => ref
            .read(sortProductsNotifierProvider.notifier)
            .selectedSort(sortProducts),
        itemBuilder: (context) => <PopupMenuEntry<SortProducts>>[
              PopupMenuItem<SortProducts>(
                value: SortProducts.lowestPrice,
                child: Text(context.loc.lowestPrice),
              ),
              PopupMenuItem<SortProducts>(
                value: SortProducts.highestPrice,
                child: Text(context.loc.highestPrice),
              ),
            ]);
  }
}

class _SupermarketsFilter extends ConsumerWidget {
  const _SupermarketsFilter(this.superMarkets);

  final List<SupermarketResponse> superMarkets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMarkets = ref.watch(superMarketsFilterNotifierProvider);
    final superMarketsFilterNotifier =
        ref.read(superMarketsFilterNotifierProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: superMarkets.map((market) {
        return CheckboxListTile(
            title: Text(market.name),
            value: selectedMarkets.contains(market.id),
            onChanged: (bool? value) {
              superMarketsFilterNotifier.toggleSupermarket(market.id);
            });
      }).toList(),
    );
  }
}
