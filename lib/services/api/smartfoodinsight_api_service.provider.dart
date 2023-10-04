import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartfoodinsight_app/services/api/smartfoodinsight_api_service.dart';

part 'smartfoodinsight_api_service.provider.g.dart';

@riverpod
SmartFoodInsightApiService apiService(ApiServiceRef ref) {
  return SmartFoodInsightApiService();
}
