import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:smartfoodinsight_app/services/services.dart';

part 'openfoodfacts_api_service_provider.g.dart';

@riverpod
OpenFoodFactsApiService openFoodFactsApiService(Ref ref) {
  return OpenFoodFactsApiService();
}
