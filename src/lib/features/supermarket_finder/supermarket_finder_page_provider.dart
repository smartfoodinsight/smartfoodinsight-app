import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/services/api/dto/dto.dart';

part 'supermarket_finder_page_provider.g.dart';

@riverpod
class SuperMarketFinderNotifier extends _$SuperMarketFinderNotifier {
  @override
  FutureOr<List<SupermarketProductResponse>> build() {
    return [];
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
