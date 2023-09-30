import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartfoodinsight_app/services/api/smartfoodinsight_api_service.dart';

final apiServiceProvider = Provider((ref) => SmartFoodInsightApiService());
