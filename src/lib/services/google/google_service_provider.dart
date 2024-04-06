import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:smartfoodinsight_app/services/services.dart';

part 'google_service_provider.g.dart';

@riverpod
GoogleService googleService(GoogleServiceRef ref) {
  return GoogleService();
}
