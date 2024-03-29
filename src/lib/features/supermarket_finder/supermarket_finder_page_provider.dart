import 'dart:ffi';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/features/supermarket_finder/sort_products.dart';
import 'package:smartfoodinsight_app/services/api/dto/dto.dart';

part 'supermarket_finder_page_provider.g.dart';

@Riverpod(keepAlive: true)
class SuperMarketsFilterNotifier extends _$SuperMarketsFilterNotifier {
  final List<int> _selectedSupermarkets = [];

  @override
  List<int> build() {
    return _selectedSupermarkets;
  }

  List<int> selectedSupermarkets() {
    return _selectedSupermarkets;
  }

  void toggleSupermarket(int supermarket) {
    if (_selectedSupermarkets.contains(supermarket)) {
      _selectedSupermarkets.remove(supermarket);
    } else {
      _selectedSupermarkets.add(supermarket);
    }
    state = [..._selectedSupermarkets];
  }
}

@riverpod
class SuperMarketFinderNotifier extends _$SuperMarketFinderNotifier {
  @override
  FutureOr<List<SupermarketProductResponse>> build() {
    return [];
  }

  void sortProducts(SortProducts sortProducts) {
    update((products) {
      if (sortProducts.index == SortProducts.lowestPrice.index) {
        products.sort((a, b) => a.price.compareTo(b.price));
      } else {
        products.sort((a, b) => b.price.compareTo(a.price));
      }
      return products;
    });
  }

  Future<void> superMarketFinderAsync(List<int> markets, String term) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final marketRequest = SupermarketRequest(markets: markets, term: term);
      final products = await ref
          .read(apiServiceProvider)
          .supermarketsProductsAsync(marketRequest);
      return products;
    });
  }

  Future<void> clearAsync() async {
    state = const AsyncData([]);
  }
}

@riverpod
Future<List<SupermarketResponse>> supermarkets(Ref ref) async {
  final markets = await ref.read(apiServiceProvider).supermarketsAsync();
  return markets;
}
