import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:smartfoodinsight_app/services/services.dart';

part 'key_storage_service_provider.g.dart';

@riverpod
KeyStorageService keyStorageService(Ref ref) {
  return KeyStorageService();
}
